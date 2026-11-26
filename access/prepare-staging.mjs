// No deployment, source modification, network calls, environment reads or real keys.
import {readFile,writeFile,cp,mkdir} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {fileURLToPath,pathToFileURL} from 'node:url';
import {join,resolve} from 'node:path';
const root=fileURLToPath(new URL('../',import.meta.url));
export function patchSource(source,kind) {
 const names={project:['deleteProject','projectId','logi_projects'],assembly:['deleteAssemblyById','assemblyId','logi_assemblies'],node:['deleteNode','nodeId','logi_nodes']};
 const [fn,arg,table]=names[kind];
 const start=source.indexOf(`async function ${fn}(${arg}) {\n  try {`);
 const end=source.indexOf('    if (error) throw error;',start);
 if(start<0||end<0||!source.slice(start,end).includes(`db.from('${table}')`)) throw Error('Deletion source changed; review required');
 return "import { atomicDelete } from './workspace-access.mjs';\n"+source.slice(0,start)+
  `async function ${fn}(${arg}) {\n  try {\n    await atomicDelete(db,'${kind}',${arg});`+source.slice(end+'    if (error) throw error;'.length);
}
export async function prepareStaging({sourceRoot=root,output=join(root,'.staging','eagle-fixture')}={}) {
 const baseline=JSON.parse(await readFile(new URL('./source-baseline.json',import.meta.url),'utf8'));
 const sources={};
 for(const [file,hash] of Object.entries(baseline.sha256)) {
  const bytes=await readFile(join(sourceRoot,file));
  if(createHash('sha256').update(bytes).digest('hex')!==hash) throw Error(`Source drift in ${file}; review before rebuilding`);
  sources[file]=bytes.toString('utf8');
 }
 const destination=resolve(output),source=resolve(sourceRoot);
 if(destination===source || !destination.startsWith(join(source,'.staging')+'/') && !destination.startsWith(join(source,'.staging')+'\\'))
  throw Error('Output must stay inside the dedicated .staging directory');
 await mkdir(destination,{recursive:true});
 for(const folder of ['css','js']) await cp(join(sourceRoot,folder),join(destination,folder),{recursive:true});
 let page=sources['index.html'].replace(/  <script src="https:\/\/celeritas7.github.io\/Akatsuki\/js\/akatsuki-broadcast.js"><\/script>\r?\n/,'');
 page=page.replace('<body>','<body><p role="status" style="padding:12px;background:#fff3cd">Eagle fixture preview — synthetic local backend only. No rollout approval.</p>');
 await writeFile(join(destination,'index.html'),page);
 let config=sources['js/config.js'];
 for(const [name,value] of Object.entries({SUPABASE_URL:'http://127.0.0.1:54321',SUPABASE_ANON_KEY:'synthetic-publishable-key-not-a-credential'})) {
  const re=new RegExp(`(export const ${name} = )[^;]+;`);
  if(!re.test(config)) throw Error('Configuration source changed');
  config=config.replace(re,`$1'${value}';`);
 }
 await writeFile(join(destination,'js/config.js'),config);
 await writeFile(join(destination,'js/database.js'),sources['js/database.js'].replace(/^if \(window.AkatsukiBroadcast\).*\r?\n/m,''));
 for(const [file,kind] of [['projects','project'],['assemblies','assembly'],['nodes','node']])
  await writeFile(join(destination,'js',file+'.js'),patchSource(sources['js/'+file+'.js'],kind));
 let auth=sources['js/auth.js'];
 const start=auth.indexOf('function handleAuthUser(user) {'),end=auth.indexOf('// HANDLE SIGN OUT',start);
 if(start<0||end<0) throw Error('Auth source changed');
 const tail=auth.lastIndexOf('// ============================================================',end);
 auth="import { createWorkspaceAccess } from './workspace-access.mjs';\n"+auth.slice(0,start)+`const workspaceAccess=createWorkspaceAccess({client:db,onState:({user,canWrite})=>{
  state.setIsAdmin(false);state.setGoogleUser(null);hideAdminUI();
  if(!user) return;
  const info={email:user.email,name:user.user_metadata?.full_name||user.user_metadata?.name||'User'};
  state.setGoogleUser(info);state.setIsAdmin(canWrite);
  if(canWrite) showAdminUI(info); else showGuestUI(info);
}});
async function handleAuthUser(user) {
  await workspaceAccess.refresh(user);
  reloadCurrentPage();
}

`+auth.slice(tail);
 auth=auth.replace("import { ADMIN_EMAIL } from './config.js';\n",'')
  .replace("event === 'SIGNED_IN' && session?.user","['SIGNED_IN','TOKEN_REFRESHED','USER_UPDATED'].includes(event) && session?.user")
  .replace('function handleSignOut() {','function handleSignOut() {\n  workspaceAccess.clear();')
  .replace('export async function handleLogout() {','export async function handleLogout() {\n  workspaceAccess.clear();');
 await writeFile(join(destination,'js/auth.js'),auth);
 await cp(new URL('./workspace-access.mjs',import.meta.url),join(destination,'js/workspace-access.mjs'));
 await writeFile(join(destination,'EAGLE-STAGING.json'),JSON.stringify({sourceCommit:baseline.commit,synthetic:true,deploymentApproved:false},null,2)+'\n');
 return destination;
}
if(process.argv[1]&&import.meta.url===pathToFileURL(resolve(process.argv[1])).href) {
 if(process.argv.slice(2).join(' ')!=='--fixture') throw Error('Use --fixture; hosted configuration is deliberately not supported');
 console.log(await prepareStaging());
}
