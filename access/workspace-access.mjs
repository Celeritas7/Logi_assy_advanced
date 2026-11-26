// Prepared staging contract only. The server verifies UUID membership and roles.
const writers=new Set(['admin','operator']);
const roles=new Set([...writers,'viewer']);
const actions=Object.freeze({assembly:'ga_eagle_delete_assembly',project:'ga_eagle_delete_project',node:'ga_eagle_archive_node'});
const uuid=/^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;
export function createWorkspaceAccess({client,onState}) {
 let revision=0;
 function clear() {revision++;onState({user:null,role:null,canWrite:false});}
 async function refresh(user) {
  const current=++revision;
  onState({user:null,role:null,canWrite:false});
  if(!user?.id) return;
  let role=null;
  try {
   const result=await client.rpc('ga_eagle_workspace_role');
   if(!result.error && roles.has(result.data)) role=result.data;
  } catch { /* No offline or email fallback for administrative actions. */ }
  if(current!==revision) return;
  onState({user,role,canWrite:writers.has(role)});
 }
 return {refresh,clear};
}
export async function atomicDelete(client,kind,id) {
 const name=Object.hasOwn(actions,kind)?actions[kind]:null;
 if(!name || !uuid.test(id)) throw Error('Invalid deletion request');
 const {data,error}=await client.rpc(name,{target_id:id});
 if(error) throw error;
 if(data!==id) throw Error('Deletion was not confirmed. Refresh before retrying.');
 return data;
}
