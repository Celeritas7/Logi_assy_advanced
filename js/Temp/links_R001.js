// ============================================================
// Logi Assembly v27 - Links Module
// ============================================================

import { db } from './database.js';
import * as state from './state.js';
import { showToast, showModal, hideModal, hideContextMenu, escapeHtml } from './ui.js';
import { loadAssemblyData } from './graph.js';

// ============================================================
// EDIT LINK FASTENER
// ============================================================
export function editLinkFastener(linkId) {
  hideContextMenu();
  
  if (!state.isAdmin) return;
  
  const link = state.links.find(l => l.id === linkId);
  if (!link) return;
  
  const sourceNode = state.nodes.find(n => n.id === link.child_id);
  const targetNode = state.nodes.find(n => n.id === link.parent_id);
  
  showModal(
    'Edit Link',
    `<p style="margin-bottom:15px;color:#666;font-size:13px;">
      ${escapeHtml(sourceNode?.name || 'Unknown')} → ${escapeHtml(targetNode?.name || 'Unknown')}
    </p>
    <div class="form-group">
      <label class="form-label">Fastener Type</label>
      <input type="text" class="form-input" id="linkFastener" value="${escapeHtml(link.fastener || '')}" placeholder="e.g., M6x20, CBE10, PRESS">
    </div>
    <div class="form-group">
      <label class="form-label">Quantity</label>
      <input type="number" class="form-input" id="linkQty" value="${link.qty || 1}" min="1">
    </div>
    <div style="margin-top:10px;font-size:11px;color:#888;">
      <strong>Common fasteners:</strong><br>
      CBE = Cap Bolt External | CBST = Cap Bolt Steel<br>
      M = Metric | MS = Machine Screw | PRESS = Press Fit
    </div>`,
    [
      { label: 'Cancel', class: 'btn-secondary', action: hideModal },
      { label: 'Save', class: 'btn-primary', action: () => saveLinkFastener(linkId) }
    ]
  );
  
  setTimeout(() => document.getElementById('linkFastener')?.focus(), 100);
}

async function saveLinkFastener(linkId) {
  const fastener = document.getElementById('linkFastener').value.trim();
  const qty = parseInt(document.getElementById('linkQty').value) || 1;
  
  try {
    const { error } = await db.from('logi_links').update({
      fastener: fastener || null,
      qty: qty
    }).eq('id', linkId);
    
    if (error) throw error;
    
    hideModal();
    showToast('Link updated', 'success');
    await loadAssemblyData(state.currentAssemblyId);
  } catch (e) {
    console.error('Error updating link:', e);
    showToast('Failed to update link: ' + e.message, 'error');
  }
}

// ============================================================
// DELETE LINK
// ============================================================
export function confirmDeleteLink(linkId) {
  hideContextMenu();
  
  if (!state.isAdmin) return;
  
  const link = state.links.find(l => l.id === linkId);
  if (!link) return;
  
  const sourceNode = state.nodes.find(n => n.id === link.child_id);
  const targetNode = state.nodes.find(n => n.id === link.parent_id);
  
  showModal(
    'Delete Link',
    `<p>Are you sure you want to delete the link between:</p>
     <p style="margin:10px 0;font-weight:600;">
       ${escapeHtml(sourceNode?.name || 'Unknown')} → ${escapeHtml(targetNode?.name || 'Unknown')}
     </p>
     <p style="color:#888;font-size:12px;">The nodes will remain, only the connection will be removed.</p>`,
    [
      { label: 'Cancel', class: 'btn-secondary', action: hideModal },
      { label: 'Delete', class: 'btn-danger', action: () => deleteLink(linkId) }
    ]
  );
}

async function deleteLink(linkId) {
  try {
    const { error } = await db.from('logi_links').update({ deleted: true }).eq('id', linkId);
    if (error) throw error;
    
    hideModal();
    showToast('Link deleted', 'success');
    await loadAssemblyData(state.currentAssemblyId);
  } catch (e) {
    console.error('Error deleting link:', e);
    showToast('Failed to delete link: ' + e.message, 'error');
  }
}

// ============================================================
// CREATE LINK (Connect existing nodes)
// ============================================================
export function showConnectNodeMenu(childId) {
  hideContextMenu();
  
  if (!state.isAdmin) return;
  
  const childNode = state.nodes.find(n => n.id === childId);
  if (!childNode) return;
  
  // Get potential parents (nodes that this node doesn't already connect to)
  const existingParents = new Set(childNode.goesInto);
  const potentialParents = state.nodes.filter(n => 
    n.id !== childId && !existingParents.has(n.id)
  );
  
  if (potentialParents.length === 0) {
    showToast('No available nodes to connect to', 'info');
    return;
  }
  
  // Sort by level (lower level = closer to root = more likely parent)
  potentialParents.sort((a, b) => a.level - b.level);
  
  const options = potentialParents.map(n => 
    `<option value="${n.id}">${escapeHtml(n.name)} (L${n.level})</option>`
  ).join('');
  
  showModal(
    'Connect to Parent',
    `<p style="margin-bottom:15px;color:#666;font-size:13px;">
      Connect "<strong>${escapeHtml(childNode.name)}</strong>" (L${childNode.level}) to a parent:
    </p>
    <div class="form-group">
      <label class="form-label">Select Parent Node</label>
      <select class="form-select" id="connectParentId" style="max-height:200px;">${options}</select>
    </div>
    <div class="form-group">
      <label class="form-label">Fastener (optional)</label>
      <input type="text" class="form-input" id="connectFastener" placeholder="e.g., M6x20, CBST 8-30">
    </div>
    <p style="margin-top:10px;color:#888;font-size:11px;">
      💡 Tip: Parent should be a lower level (closer to L1) than this node.
    </p>`,
    [
      { label: 'Cancel', class: 'btn-secondary', action: hideModal },
      { label: 'Connect', class: 'btn-primary', action: () => createConnection(childId) }
    ]
  );
}

async function createConnection(childId) {
  const parentId = document.getElementById('connectParentId').value;
  const fastener = document.getElementById('connectFastener').value.trim();
  
  if (!parentId) {
    showToast('Please select a parent node', 'error');
    return;
  }
  
  try {
    const { error } = await db.from('logi_links').insert({
      assembly_id: state.currentAssemblyId,
      parent_id: parentId,
      child_id: childId,
      fastener: fastener || null
    });
    
    if (error) throw error;
    
    hideModal();
    showToast('Connection created', 'success');
    await loadAssemblyData(state.currentAssemblyId);
  } catch (e) {
    console.error('Error creating connection:', e);
    showToast('Failed to create connection: ' + e.message, 'error');
  }
}

// ============================================================
// EXPORTS TO WINDOW
// ============================================================
window.editLinkFastener = editLinkFastener;
window.confirmDeleteLink = confirmDeleteLink;
window.showConnectNodeMenu = showConnectNodeMenu;
