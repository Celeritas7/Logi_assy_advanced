import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile,mkdtemp,cp,rm,writeFile} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {fileURLToPath} from 'node:url';
import {atomicDelete,createWorkspaceAccess} from '../access/workspace-access.mjs';
import {prepareStaging} from '../access/prepare-staging.mjs';
const id='70000000-0000-4000-8000-000000000001';
const user={id,email:'fictional@example.invalid',user_metadata:{role:'admin'}};
test('destructive actions issue exactly one RPC; errors never fall back to direct deletion',async()=>{
 for(const [kind,name] of [['assembly','ga_eagle_delete_assembly'],['project','ga_eagle_delete_project'],['node','ga_eagle_archive_node']]) {
  let calls=[];const client={rpc:async(...args)=>{calls.push(args);return {data:id,error:null};}};
  assert.equal(await atomicDelete(client,kind,id),id);assert.deepEqual(calls,[[name,{target_id:id}]]);
  client.rpc=async()=>({error:Error('denied')});await assert.rejects(()=>atomicDelete(client,kind,id),/denied/);
  client.rpc=async()=>({data:null});await assert.rejects(()=>atomicDelete(client,kind,id),/not confirmed/);
 }
 let calls=0;await assert.rejects(()=>atomicDelete({rpc:()=>calls++},'__proto__',id));assert.equal(calls,0);
});
test('verified server roles alone enable controls; stale account responses cannot restore them',async()=>{
 const states=[];let reply;const access=createWorkspaceAccess({client:{rpc:()=>new Promise(resolve=>reply=resolve)},onState:s=>states.push(s)});
 const pending=access.refresh(user);assert.equal(states.at(-1).canWrite,false);access.clear();reply({data:'admin'});await pending;
 assert.equal(states.at(-1).user,null);
 const first=access.refresh(user),oldReply=reply;
 const next=access.refresh({...user,id:'other'});reply({data:'viewer'});await next;oldReply({data:'admin'});await first;
 assert.equal(states.at(-1).role,'viewer');assert.equal(states.at(-1).canWrite,false);
 for(const role of ['operator','admin','viewer',null,'invented']) {
  const run=access.refresh(user);reply({data:role});await run;
  assert.equal(states.at(-1).canWrite,['operator','admin'].includes(role));
 }
 const fail=createWorkspaceAccess({client:{rpc:async()=>{throw Error('offline');}},onState:s=>states.push(s)});
 await fail.refresh(user);assert.equal(states.at(-1).canWrite,false);
});
test('fixture staging preserves production sources, uses local synthetic config and rejects drift',async()=>{
 const temporary=await mkdtemp(join(tmpdir(),'logi-eagle-'));
 const root=fileURLToPath(new URL('../',import.meta.url));
 try {
  for(const file of ['index.html','js','css']) await cp(join(root,file),join(temporary,file),{recursive:true});
  const before=await readFile(join(temporary,'js/auth.js'),'utf8');
  const output=await prepareStaging({sourceRoot:temporary,output:join(temporary,'.staging','fixture')});
  assert.equal(await readFile(join(temporary,'js/auth.js'),'utf8'),before);
  const config=await readFile(join(output,'js/config.js'),'utf8');
  assert.match(config,/127\.0\.0\.1:54321/);assert.doesNotMatch(config,/wylxvmkcrexwfpjpbhyy/);
  const auth=await readFile(join(output,'js/auth.js'),'utf8');
  assert.match(auth,/workspaceAccess.refresh/);assert.doesNotMatch(auth,/ADMIN_EMAIL/);assert.match(auth,/TOKEN_REFRESHED/);
  for(const file of ['projects','assemblies','nodes']) {
   const source=await readFile(join(output,'js',file+'.js'),'utf8');
   assert.match(source,/await atomicDelete/);assert.doesNotMatch(source,/db\.from\('logi_\w+'\)\.delete/);
  }
  assert.doesNotMatch(await readFile(join(output,'js/database.js'),'utf8'),/AkatsukiBroadcast/);
  await assert.rejects(()=>prepareStaging({sourceRoot:temporary,output:temporary}),/dedicated/);
  await writeFile(join(temporary,'js/nodes.js'),'changed');
  await assert.rejects(()=>prepareStaging({sourceRoot:temporary,output:join(temporary,'.staging','other')}),/Source drift/);
 } finally {await rm(temporary,{recursive:true,force:true});}
});
