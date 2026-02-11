// ============================================================
// Logi Assembly v28 - Graph Visualization Module
// ============================================================

import { db } from './database.js';
import {
  LEVEL_COLORS, LEVEL_SHAPES, LEVEL_FONT_SIZES, LEVEL_FONT_WEIGHTS,
  GROUP_COLORS, STATUS_COLORS, FASTENER_COLORS, SEQUENCE_BADGES,
  NODE_WIDTH_BASE, NODE_WIDTH_MAX,
  getLevelColor, getLevelShape, getLevelFontSize, getLevelFontWeight,
  getGroupColor, getStatusColor, getFastenerColor, getSequenceBadge
} from './config.js';
import * as state from './state.js';
import {
  showToast, showLoading, setStatus, showModal, hideModal,
  showContextMenu, hideContextMenu, openSidePanel, closeSidePanel,
  setSidePanelContent, updateUndoButton, escapeHtml
} from './ui.js';

// ============================================================
// ZOOM STATE & CONTROLS
// ============================================================
let zoomBehavior = null;
let currentTransform = d3.zoomIdentity;

export function initZoom() {
  const svg = d3.select('#treeSvg');
  const g = svg.select('g.zoom-group');
  
  zoomBehavior = d3.zoom()
    .scaleExtent([0.1, 3])
    .on('zoom', (event) => {
      currentTransform = event.transform;
      g.attr('transform', event.transform);
    });
  
  svg.call(zoomBehavior);
}

export function zoomIn() {
  const svg = d3.select('#treeSvg');
  svg.transition().duration(300).call(zoomBehavior.scaleBy, 1.3);
}

export function zoomOut() {
  const svg = d3.select('#treeSvg');
  svg.transition().duration(300).call(zoomBehavior.scaleBy, 0.7);
}

export function fitToScreen() {
  if (state.nodes.length === 0) return;
  
  const container = document.getElementById('treeContainer');
  const svg = d3.select('#treeSvg');
  
  // Calculate bounds of all nodes
  let minX = Infinity, maxX = -Infinity, minY = Infinity, maxY = -Infinity;
  state.nodes.forEach(n => {
    if (n.deleted) return;
    minX = Math.min(minX, (n.x || 400) - 80);
    maxX = Math.max(maxX, (n.x || 400) + 80);
    minY = Math.min(minY, (n.y || 300) - 40);
    maxY = Math.max(maxY, (n.y || 300) + 40);
  });
  
  const contentWidth = maxX - minX;
  const contentHeight = maxY - minY;
  const containerWidth = container.clientWidth - 40;
  const containerHeight = container.clientHeight - 40;
  
  const scale = Math.min(
    containerWidth / contentWidth,
    containerHeight / contentHeight,
    1.5 // Max zoom for fit
  ) * 0.9; // 90% to add some padding
  
  const centerX = (minX + maxX) / 2;
  const centerY = (minY + maxY) / 2;
  
  const translateX = containerWidth / 2 - centerX * scale;
  const translateY = containerHeight / 2 - centerY * scale;
  
  const transform = d3.zoomIdentity
    .translate(translateX, translateY)
    .scale(scale);
  
  svg.transition().duration(500).call(zoomBehavior.transform, transform);
}

export function resetView() {
  const svg = d3.select('#treeSvg');
  svg.transition().duration(300).call(zoomBehavior.transform, d3.zoomIdentity);
}

// Make functions globally available
window.zoomIn = zoomIn;
window.zoomOut = zoomOut;
window.fitToScreen = fitToScreen;
window.resetView = resetView;

// ============================================================
// LOAD ASSEMBLY DATA
// ============================================================
export async function loadAssemblyData(assemblyId) {
  showLoading(true);
  setStatus('Loading...', 'loading');
  
  // Load nodes
  const { data: nodesData, error: nodesError } = await db
    .from('logi_nodes')
    .select('*')
    .eq('assembly_id', assemblyId)
    .eq('deleted', false);
  
  if (nodesError) {
    showToast('Failed to load nodes', 'error');
    console.error(nodesError);
    showLoading(false);
    return;
  }
  
  // Load links
  const { data: linksData, error: linksError } = await db
    .from('logi_links')
    .select('*')
    .eq('assembly_id', assemblyId);
  
  if (linksError) {
    showToast('Failed to load links', 'error');
    console.error(linksError);
    showLoading(false);
    return;
  }
  
  // Filter deleted links client-side
  const activeLinks = (linksData || []).filter(l => l.deleted !== true);
  
  console.log('Loaded nodes:', nodesData?.length, 'links:', activeLinks.length);
  
  // Clear and rebuild locked nodes
  state.clearLockedNodes();
  
  // Process nodes
  const processedNodes = nodesData.map(n => {
    if (n.is_locked) {
      state.addLockedNode(n.id);
    }
    
    return {
      ...n,
      goesInto: [],
      receivesFrom: [],
      level: -1,
      width: calculateNodeWidth(n.name, n.part_number),
      height: calculateNodeHeight(n.name, n.part_number),
      fx: n.is_locked ? n.x : null,
      fy: n.is_locked ? n.y : null
    };
  });
  
  state.setNodes(processedNodes);
  state.setLinks(activeLinks);
  
  // Build relationships
  const nodeMap = new Map(state.nodes.map(n => [n.id, n]));
  
  state.links.forEach(link => {
    const child = nodeMap.get(link.child_id);
    const parent = nodeMap.get(link.parent_id);
    
    if (child && parent) {
      if (!child.goesInto.includes(link.parent_id)) {
        child.goesInto.push(link.parent_id);
      }
      if (!parent.receivesFrom.includes(link.child_id)) {
        parent.receivesFrom.push(link.child_id);
      }
    }
  });
  
  // Debug: Log relationships
  const rootNodes = state.nodes.filter(n => n.goesInto.length === 0);
  if (rootNodes.length > 0) {
    console.log('Root nodes:', rootNodes.map(n => `${n.name} (${n.receivesFrom.length} children)`).join(', '));
  }
  
  // Calculate levels
  calculateLevels();
  
  // Debug: Log level assignments
  console.log('Levels:', state.nodes.map(n => `${n.name}: L${n.level}`).join(', '));
  
  // Render
  renderGraph();
  
  const lockedCount = state.lockedNodes.size;
  setStatus(`Loaded ${state.nodes.length} nodes (${lockedCount} locked)`, 'success');
  setTimeout(() => setStatus(''), 2000);
  showLoading(false);
}

// ============================================================
// CALCULATE LEVELS (L1 = Root, increasing downward)
// ============================================================
function calculateLevels() {
  // Reset all levels
  state.nodes.forEach(n => n.level = -1);
  
  // Find root nodes (no parents)
  const rootNodes = state.nodes.filter(n => n.goesInto.length === 0);
  
  if (rootNodes.length === 0) {
    console.log('No root nodes found, assigning level 1 to all');
    state.nodes.forEach(n => n.level = 1);
    return;
  }
  
  console.log('Root nodes:', rootNodes.map(n => n.name).join(', '));
  
  // BFS from root nodes (L1 → L2 → L3 → ...)
  const queue = [];
  const visited = new Set();
  
  rootNodes.forEach(root => {
    root.level = 1;
    queue.push(root.id);
    visited.add(root.id);
    console.log(`Root: ${root.name} = L1`);
  });
  
  while (queue.length > 0) {
    const nodeId = queue.shift();
    const node = state.nodes.find(n => n.id === nodeId);
    if (!node) continue;
    
    // Children get level = parent + 1
    node.receivesFrom.forEach(childId => {
      const child = state.nodes.find(n => n.id === childId);
      if (child) {
        const newLevel = node.level + 1;
        if (child.level === -1 || newLevel > child.level) {
          console.log(`${child.name} → L${newLevel} (child of ${node.name})`);
          child.level = newLevel;
        }
        if (!visited.has(childId)) {
          visited.add(childId);
          queue.push(childId);
        }
      }
    });
  }
  
  // Handle orphans
  state.nodes.forEach(n => {
    if (n.level === -1) {
      let minParentLevel = Infinity;
      n.goesInto.forEach(parentId => {
        const parent = state.nodes.find(p => p.id === parentId);
        if (parent && parent.level > 0) {
          minParentLevel = Math.min(minParentLevel, parent.level);
        }
      });
      n.level = minParentLevel < Infinity ? minParentLevel + 1 : 1;
      console.log(`Orphan ${n.name} → L${n.level}`);
    }
  });
}

// ============================================================
// NODE DIMENSIONS
// ============================================================
function calculateNodeWidth(name, partNumber) {
  let width = NODE_WIDTH_BASE;
  if (name && name.length > 12) {
    width = Math.min(NODE_WIDTH_MAX, NODE_WIDTH_BASE + (name.length - 12) * 4);
  }
  if (partNumber && partNumber.length > 10) {
    width = Math.max(width, Math.min(NODE_WIDTH_MAX, 100 + partNumber.length * 4));
  }
  return width;
}

function calculateNodeHeight(name, partNumber) {
  let height = 36;
  if (partNumber) height += 10;
  if (name && name.length > 20) height += 8;
  return height;
}

// ============================================================
// GET NODE COLOR
// ============================================================
function getNodeColor(node) {
  const colorMode = state.currentColorMode;
  
  if (colorMode === 'status') {
    const statusColor = STATUS_COLORS[node.status];
    return statusColor ? statusColor.bg : LEVEL_COLORS[0];
  }
  
  if (colorMode === 'group') {
    return GROUP_COLORS[(node.group_num || 0) % GROUP_COLORS.length];
  }
  
  // Default: level coloring
  return getLevelColor(node.level);
}

// ============================================================
// NODE VISIBILITY - Check all ancestors for collapse
// ============================================================
function isNodeVisible(node) {
  if (state.currentLevelFilter !== 'all' && node.level > parseInt(state.currentLevelFilter)) {
    return false;
  }
  
  // Root nodes always visible
  if (node.goesInto.length === 0) return true;
  
  // Check if ANY ancestor is collapsed (recursive)
  return !hasCollapsedAncestor(node.id, new Set());
}

// Helper: Recursively check if any ancestor is collapsed
function hasCollapsedAncestor(nodeId, visited) {
  if (visited.has(nodeId)) return false;
  visited.add(nodeId);
  
  const node = state.nodes.find(n => n.id === nodeId);
  if (!node) return false;
  
  // Check each parent
  for (const parentId of node.goesInto) {
    // If direct parent is collapsed, hide this node
    if (state.collapsedNodes.has(parentId)) return true;
    
    // Recursively check if parent has collapsed ancestor
    if (hasCollapsedAncestor(parentId, visited)) return true;
  }
  
  return false;
}

// ============================================================
// CALCULATE SMOOTH LINK PATH (Edge-center Bezier curves)
// ============================================================
function calculateLinkPath(source, target) {
  const sourceW = source.width / 2;
  const sourceH = source.height / 2;
  const targetW = target.width / 2;
  const targetH = target.height / 2;
  
  const dx = target.x - source.x;
  const dy = target.y - source.y;
  const absDx = Math.abs(dx);
  const absDy = Math.abs(dy);
  
  let sx, sy, tx, ty;
  
  // Smart edge detection - connect from appropriate edge centers
  if (absDx > absDy * 1.5) {
    // Mostly horizontal - connect from left/right edges
    if (dx > 0) {
      sx = source.x + sourceW;  // Right edge of source
      tx = target.x - targetW;  // Left edge of target
    } else {
      sx = source.x - sourceW;  // Left edge of source
      tx = target.x + targetW;  // Right edge of target
    }
    sy = source.y;  // Center vertically
    ty = target.y;
  } else if (absDy > absDx * 1.5) {
    // Mostly vertical - connect from top/bottom edges
    if (dy > 0) {
      sy = source.y + sourceH;  // Bottom edge of source
      ty = target.y - targetH;  // Top edge of target
    } else {
      sy = source.y - sourceH;  // Top edge of source
      ty = target.y + targetH;  // Bottom edge of target
    }
    sx = source.x;  // Center horizontally
    tx = target.x;
  } else {
    // Diagonal - use corner-ish but from edges
    if (dx > 0) {
      sx = source.x + sourceW;
      tx = target.x - targetW;
    } else {
      sx = source.x - sourceW;
      tx = target.x + targetW;
    }
    // Slight vertical offset based on direction
    sy = source.y + (dy > 0 ? sourceH * 0.3 : -sourceH * 0.3);
    ty = target.y + (dy > 0 ? -targetH * 0.3 : targetH * 0.3);
  }
  
  // Calculate smooth control points at midpoint
  const midX = (sx + tx) / 2;
  const midY = (sy + ty) / 2;
  
  // Gentle curve - control points pull toward midpoint
  let cx1, cy1, cx2, cy2;
  
  if (absDx > absDy) {
    // Horizontal dominant - S-curve
    cx1 = midX;
    cy1 = sy;
    cx2 = midX;
    cy2 = ty;
  } else {
    // Vertical dominant - S-curve
    cx1 = sx;
    cy1 = midY;
    cx2 = tx;
    cy2 = midY;
  }
  
  return `M ${sx},${sy} C ${cx1},${cy1} ${cx2},${cy2} ${tx},${ty}`;
}

// ============================================================
// DARKEN COLOR - Create darker border from fill color
// ============================================================
function darkenColor(hex, percent = 30) {
  // Remove # if present
  hex = hex.replace('#', '');
  
  // Parse RGB
  let r = parseInt(hex.substring(0, 2), 16);
  let g = parseInt(hex.substring(2, 4), 16);
  let b = parseInt(hex.substring(4, 6), 16);
  
  // Darken
  r = Math.max(0, Math.floor(r * (100 - percent) / 100));
  g = Math.max(0, Math.floor(g * (100 - percent) / 100));
  b = Math.max(0, Math.floor(b * (100 - percent) / 100));
  
  // Convert back to hex
  return `#${r.toString(16).padStart(2, '0')}${g.toString(16).padStart(2, '0')}${b.toString(16).padStart(2, '0')}`;
}

// ============================================================
// DRAW SHAPE - v28 with matching border colors
// ============================================================
function drawShape(selection, shapeType, width, height, fill, stroke, isMultiParent, isOrphan) {
  const halfW = width / 2, halfH = height / 2;
  const strokeWidth = (isMultiParent || isOrphan) ? 2 : 1.5;
  const dashArray = isOrphan ? '5,3' : 'none';
  
  // v28: Border color matches fill (darker variant) instead of uniform gray
  let finalStroke;
  if (isOrphan) {
    finalStroke = '#9b59b6';
  } else {
    finalStroke = darkenColor(fill, 35);  // 35% darker than fill
  }

  selection.selectAll('.node-shape, .multi-parent-indicator').remove();

  const shapes = {
    rectangle: () => {
      selection.insert('rect', ':first-child').attr('class', 'node-shape')
        .attr('x', -halfW).attr('y', -halfH).attr('width', width).attr('height', height)
        .attr('fill', fill).attr('stroke', finalStroke).attr('stroke-width', strokeWidth)
        .attr('stroke-dasharray', dashArray).attr('rx', 0);
    },
    rounded_rectangle: () => {
      selection.insert('rect', ':first-child').attr('class', 'node-shape')
        .attr('x', -halfW).attr('y', -halfH).attr('width', width).attr('height', height)
        .attr('fill', fill).attr('stroke', finalStroke).attr('stroke-width', strokeWidth)
        .attr('stroke-dasharray', dashArray).attr('rx', 6);
    },
    stadium: () => {
      selection.insert('rect', ':first-child').attr('class', 'node-shape')
        .attr('x', -halfW).attr('y', -halfH).attr('width', width).attr('height', height)
        .attr('fill', fill).attr('stroke', finalStroke).attr('stroke-width', strokeWidth)
        .attr('stroke-dasharray', dashArray).attr('rx', halfH).attr('ry', halfH);
    },
    parallelogram: () => {
      const sk = 10;
      const pts = `${-halfW+sk},${-halfH} ${halfW+sk},${-halfH} ${halfW-sk},${halfH} ${-halfW-sk},${halfH}`;
      selection.insert('polygon', ':first-child').attr('class', 'node-shape')
        .attr('points', pts).attr('fill', fill).attr('stroke', finalStroke)
        .attr('stroke-width', strokeWidth).attr('stroke-dasharray', dashArray);
    },
    pentagon: () => {
      const a = (2*Math.PI)/5, sa = -Math.PI/2, rx = halfW*0.85, ry = halfH*0.9;
      const pts = Array.from({length:5}, (_,i) => `${rx*Math.cos(sa+i*a)},${ry*Math.sin(sa+i*a)}`).join(' ');
      selection.insert('polygon', ':first-child').attr('class', 'node-shape')
        .attr('points', pts).attr('fill', fill).attr('stroke', finalStroke)
        .attr('stroke-width', strokeWidth).attr('stroke-dasharray', dashArray);
    },
    hexagon: () => {
      const pts = `${-halfW+10},${-halfH} ${halfW-10},${-halfH} ${halfW},0 ${halfW-10},${halfH} ${-halfW+10},${halfH} ${-halfW},0`;
      selection.insert('polygon', ':first-child').attr('class', 'node-shape')
        .attr('points', pts).attr('fill', fill).attr('stroke', finalStroke)
        .attr('stroke-width', strokeWidth).attr('stroke-dasharray', dashArray);
    },
    diamond: () => {
      const pts = `0,${-halfH} ${halfW},0 0,${halfH} ${-halfW},0`;
      selection.insert('polygon', ':first-child').attr('class', 'node-shape')
        .attr('points', pts).attr('fill', fill).attr('stroke', finalStroke)
        .attr('stroke-width', strokeWidth).attr('stroke-dasharray', dashArray);
    },
    ellipse: () => {
      selection.insert('ellipse', ':first-child').attr('class', 'node-shape')
        .attr('cx', 0).attr('cy', 0).attr('rx', halfW).attr('ry', halfH)
        .attr('fill', fill).attr('stroke', finalStroke)
        .attr('stroke-width', strokeWidth).attr('stroke-dasharray', dashArray);
    },
    octagon: () => {
      const c = Math.min(halfW, halfH) * 0.35;
      const pts = `${-halfW+c},${-halfH} ${halfW-c},${-halfH} ${halfW},${-halfH+c} ${halfW},${halfH-c} ${halfW-c},${halfH} ${-halfW+c},${halfH} ${-halfW},${halfH-c} ${-halfW},${-halfH+c}`;
      selection.insert('polygon', ':first-child').attr('class', 'node-shape')
        .attr('points', pts).attr('fill', fill).attr('stroke', finalStroke)
        .attr('stroke-width', strokeWidth).attr('stroke-dasharray', dashArray);
    }
  };
  
  (shapes[shapeType] || shapes.rectangle)();
  
  if (isMultiParent) {
    // Multi-parent indicator uses darker version of fill color too
    selection.insert('rect', ':first-child').attr('class', 'multi-parent-indicator')
      .attr('x', -halfW - 3).attr('y', -halfH - 3)
      .attr('width', width + 6).attr('height', height + 6)
      .attr('stroke', darkenColor(fill, 50)).attr('stroke-width', 1.5).attr('rx', 4).attr('fill', 'none');
  }
}

// ============================================================
// RENDER GRAPH
// ============================================================
export function renderGraph() {
  const container = document.getElementById('treeContainer');
  container.querySelector('svg').innerHTML = '';
  
  if (state.nodes.length === 0) {
    const svg = d3.select('#treeSvg')
      .attr('width', container.clientWidth)
      .attr('height', container.clientHeight);
    
    svg.append('text')
      .attr('x', container.clientWidth / 2)
      .attr('y', container.clientHeight / 2)
      .attr('text-anchor', 'middle')
      .attr('fill', '#999')
      .attr('font-size', '16px')
      .text(state.isAdmin ? 'Right-click to add a root node' : 'No nodes in this assembly');
    
    return;
  }
  
  const visibleNodes = state.nodes.filter(isNodeVisible);
  const visibleNodeIds = new Set(visibleNodes.map(n => n.id));
  const visibleLinks = state.links.filter(l => 
    visibleNodeIds.has(l.parent_id) && visibleNodeIds.has(l.child_id)
  );
  
  // Calculate bounds
  let minX = Infinity, maxX = -Infinity, minY = Infinity, maxY = -Infinity;
  visibleNodes.forEach(n => {
    minX = Math.min(minX, (n.x || 400) - 100);
    maxX = Math.max(maxX, (n.x || 400) + 100);
    minY = Math.min(minY, (n.y || 300) - 50);
    maxY = Math.max(maxY, (n.y || 300) + 50);
  });
  
  const padding = 200;
  const width = Math.max(container.clientWidth, maxX - minX + padding * 2);
  const height = Math.max(container.clientHeight, maxY - minY + padding * 2);
  
  const svg = d3.select('#treeSvg')
    .attr('width', width)
    .attr('height', height);
  
  // Arrow markers - v28: smaller, better positioned
  const defs = svg.append('defs');
  defs.append('marker')
    .attr('id', 'arrowhead')
    .attr('viewBox', '0 0 10 10')
    .attr('refX', 9)
    .attr('refY', 5)
    .attr('orient', 'auto')
    .attr('markerWidth', 5)
    .attr('markerHeight', 5)
    .append('path')
    .attr('d', 'M 0,1 L 8,5 L 0,9 z')
    .attr('fill', '#666');
  
  // Main group
  const g = svg.append('g')
    .attr('class', 'zoom-group');
  
  // Initialize zoom behavior
  initZoom();
  
  // Render links with curved paths
  const linkGroups = g.selectAll('.link-group')
    .data(visibleLinks, d => `${d.child_id}-${d.parent_id}`)
    .enter()
    .append('g')
    .attr('class', 'link-group');
  
  linkGroups.each(function(linkData) {
    const group = d3.select(this);
    const source = visibleNodes.find(n => n.id === linkData.child_id);
    const target = visibleNodes.find(n => n.id === linkData.parent_id);
    
    if (!source || !target) return;
    
    // Get color
    const fastenerColor = getFastenerColor(linkData.fastener);
    
    // Draw curved link path using Bezier curves
    group.append('path')
      .attr('class', 'link')
      .attr('d', calculateLinkPath(source, target))
      .attr('stroke', fastenerColor)
      .attr('stroke-width', 1.5)
      .attr('fill', 'none')
      .attr('marker-end', 'url(#arrowhead)')
      .on('contextmenu', (e) => {
        if (!state.isAdmin) return;
        e.preventDefault();
        showLinkContextMenu(e.clientX, e.clientY, linkData);
      });
    
    // Link label at midpoint (Fastener, Loctite, Torque)
    // Always show a clickable area even if no label data
    const midX = (source.x + target.x) / 2;
    const midY = (source.y + target.y) / 2;
    
    const hasLabel = linkData.fastener || linkData.loctite || linkData.torque_value;
    
    // Build label lines
    const lines = [];
    
    if (linkData.fastener) {
      const fastenerText = linkData.fastener + (linkData.qty > 1 ? ` ×${linkData.qty}` : '');
      lines.push({ text: fastenerText, color: fastenerColor, bold: true });
    }
    
    if (linkData.loctite) {
      lines.push({ text: `LT-${linkData.loctite}`, color: '#9b59b6', bold: false });
    }
    
    if (linkData.torque_value) {
      const torqueText = `${linkData.torque_value}${linkData.torque_unit || 'Nm'}`;
      lines.push({ text: torqueText, color: '#e67e22', bold: false });
    }
    
    // Calculate label dimensions
    const lineHeight = 11;
    const labelHeight = hasLabel ? (lines.length * lineHeight + 6) : 20;
    const labelWidth = hasLabel ? Math.max(50, ...lines.map(l => l.text.length * 5.5 + 10)) : 30;
    
    // Background rect - ALWAYS clickable for easy editing
    group.append('rect')
      .attr('class', 'link-label-bg link-clickable')
      .attr('x', midX - labelWidth / 2)
      .attr('y', midY - labelHeight / 2)
      .attr('width', labelWidth)
      .attr('height', labelHeight)
      .attr('rx', 3)
      .style('cursor', state.isAdmin ? 'pointer' : 'default')
      .style('opacity', hasLabel ? 0.95 : 0)
      .on('click', (e) => {
        if (!state.isAdmin) return;
        e.stopPropagation();
        window.editLinkFastener(linkData.id);
      })
      .on('contextmenu', (e) => {
        if (!state.isAdmin) return;
        e.preventDefault();
        showLinkContextMenu(e.clientX, e.clientY, linkData);
      })
      .on('mouseover', function() {
        if (state.isAdmin) {
          d3.select(this).style('opacity', 1).attr('stroke', '#3498db').attr('stroke-width', 1);
        }
      })
      .on('mouseout', function() {
        d3.select(this).style('opacity', hasLabel ? 0.95 : 0).attr('stroke', 'none');
      });
    
    // Render label text lines
    if (hasLabel) {
      lines.forEach((line, i) => {
        const yOffset = midY - labelHeight / 2 + 10 + (i * lineHeight);
        group.append('text')
          .attr('class', 'link-label')
          .attr('x', midX)
          .attr('y', yOffset)
          .attr('text-anchor', 'middle')
          .attr('fill', line.color)
          .attr('font-weight', line.bold ? '600' : '400')
          .attr('font-size', '8px')
          .style('pointer-events', 'none')  // Let clicks pass through to background
          .text(line.text);
      });
    }
  });
  
  // Render nodes
  const nodeElements = g.selectAll('.node')
    .data(visibleNodes, d => d.id)
    .enter()
    .append('g')
    .attr('class', d => `node ${state.lockedNodes.has(d.id) ? 'locked' : ''}`)
    .attr('transform', d => `translate(${d.x || 400}, ${d.y || 300})`);
  
  nodeElements.each(function(d) {
    const group = d3.select(this);
    const color = getNodeColor(d);
    const shape = getLevelShape(d.level);
    const isMultiParent = d.goesInto.length > 1;
    const isOrphan = d.goesInto.length === 0 && d.receivesFrom.length === 0 && state.nodes.length > 1;
    
    // Draw shape
    drawShape(group, shape, d.width, d.height, color, '#555', isMultiParent, isOrphan);
    
    // v28: Status indicator dot (top-left, visible to all)
    const statusColors = {
      'DONE': '#27ae60',
      'IN_PROGRESS': '#f39c12',
      'BLOCKED': '#e74c3c',
      'NOT_STARTED': '#95a5a6',
      'ON_HOLD': '#9b59b6',
      'REVIEW': '#3498db'
    };
    const statusColor = statusColors[d.status] || '#95a5a6';
    
    group.append('circle')
      .attr('class', 'status-indicator')
      .attr('cx', -d.width/2 + 10)
      .attr('cy', -d.height/2 + 10)
      .attr('r', 5)
      .attr('fill', statusColor)
      .attr('stroke', 'white')
      .attr('stroke-width', 1.5);
    
    // Get font styling
    const fontSize = getLevelFontSize(d.level);
    const fontWeight = getLevelFontWeight(d.level);
    
    // Node label
    group.append('text')
      .attr('class', 'node-label')
      .attr('text-anchor', 'middle')
      .attr('y', d.part_number ? -3 : 4)
      .attr('font-size', fontSize + 'px')
      .attr('font-weight', fontWeight)
      .text(d.name);
    
    // Part number (always 7px)
    if (d.part_number) {
      group.append('text')
        .attr('class', 'node-pn')
        .attr('text-anchor', 'middle')
        .attr('y', 12)
        .attr('font-size', '7px')
        .text(d.part_number);
    }
    
    // Sequence badge
    if (d.sequence_num != null && d.sequence_num > 0) {
      group.append('text')
        .attr('class', 'sequence-badge')
        .attr('x', d.width/2 - 5)
        .attr('y', -d.height/2 + 5)
        .text(getSequenceBadge(d.sequence_num));
    }
  });
  
  // Collapse indicators - positioned on RIGHT side of node
  nodeElements.filter(d => d.receivesFrom.length > 0).each(function(d) {
    const group = d3.select(this);
    const isCollapsed = state.collapsedNodes.has(d.id);
    
    // Circle on right edge
    group.append('circle')
      .attr('class', 'collapse-indicator')
      .attr('cx', d.width/2 + 12)
      .attr('cy', 0)
      .attr('r', 8)
      .on('click', (e) => {
        e.stopPropagation();
        toggleCollapse(d.id);
      });
    
    // +/- text
    group.append('text')
      .attr('class', 'toggle-icon')
      .attr('x', d.width/2 + 12)
      .attr('y', 0)
      .attr('text-anchor', 'middle')
      .attr('dy', '0.35em')
      .attr('font-size', '12px')
      .text(isCollapsed ? '+' : '−')
      .style('cursor', 'pointer')
      .on('click', (e) => {
        e.stopPropagation();
        toggleCollapse(d.id);
      });
  });
  
  // Lock indicators
  if (state.isAdmin) {
    nodeElements.filter(d => state.lockedNodes.has(d.id)).each(function(d) {
      d3.select(this).append('text')
        .attr('class', 'lock-indicator')
        .attr('x', d.width/2 - 8)
        .attr('y', d.height/2 - 6)
        .attr('text-anchor', 'middle')
        .attr('font-size', '10px')
        .text('🔒');
    });
  }
  
  // Setup interactions
  setupNodeInteractions(nodeElements);
  
  // Setup force simulation
  if (state.currentLayoutMode === 'force') {
    setupForceSimulation(visibleNodes, visibleLinks);
  }
}

// ============================================================
// NODE INTERACTIONS
// ============================================================
function setupNodeInteractions(nodeElements) {
  // Drag behavior
  const drag = d3.drag()
    .on('start', dragStarted)
    .on('drag', dragged)
    .on('end', dragEnded);
  
  nodeElements.call(drag);
  
  // Click to select
  nodeElements.on('click', (e, d) => {
    e.stopPropagation();
    if (state.isAdmin) {
      openNodeEditPanel(d);
    }
  });
  
  // Right-click context menu
  nodeElements.on('contextmenu', (e, d) => {
    if (!state.isAdmin) return;
    e.preventDefault();
    showNodeContextMenu(e.clientX, e.clientY, d);
  });
}

// ============================================================
// DRAG HANDLERS
// ============================================================
function dragStarted(event, d) {
  if (!state.isAdmin) return;
  
  // Locked nodes can only be moved with Shift key
  if (state.lockedNodes.has(d.id) && !state.shiftKeyPressed) {
    showToast('Node is locked. Use Shift+Drag to move.', 'warning');
    return;
  }
  
  // Save position for undo
  const nodesToSave = state.shiftKeyPressed ? getNodeWithChildren(d.id) : [d];
  state.pushPositionHistory({
    nodes: nodesToSave.map(n => ({ id: n.id, x: n.x, y: n.y }))
  });
  updateUndoButton();
  
  if (state.simulation) {
    state.simulation.alphaTarget(0.3).restart();
  }
  
  d.fx = d.x;
  d.fy = d.y;
  
  // Mark as dragging
  state.isDragging = true;
}

function dragged(event, d) {
  if (!state.isAdmin) return;
  
  // Locked nodes can only be moved with Shift key
  if (state.lockedNodes.has(d.id) && !state.shiftKeyPressed) return;
  
  const dx = event.x - d.fx;
  const dy = event.y - d.fy;
  
  if (state.shiftKeyPressed) {
    // Move with children (including locked ones when Shift is held)
    const nodesToMove = getNodeWithChildren(d.id);
    nodesToMove.forEach(n => {
      n.x += dx;
      n.y += dy;
      n.fx = n.x;
      n.fy = n.y;
    });
  } else {
    d.x = event.x;
    d.y = event.y;
    d.fx = event.x;
    d.fy = event.y;
  }
  
  // Update positions smoothly WITHOUT re-rendering entire graph
  updatePositions();
}

function dragEnded(event, d) {
  if (!state.isAdmin) return;
  
  // Locked nodes can only be moved with Shift key
  if (state.lockedNodes.has(d.id) && !state.shiftKeyPressed) return;
  
  if (state.simulation) {
    state.simulation.alphaTarget(0);
  }
  
  // Keep locked nodes fixed
  if (!state.lockedNodes.has(d.id)) {
    d.fx = null;
    d.fy = null;
  }
  
  // Mark as not dragging
  state.isDragging = false;
  
  // Do a full render on drag end to update bounds if needed
  renderGraph();
}

// ============================================================
// UPDATE POSITIONS (smooth, no re-render)
// ============================================================
function updatePositions() {
  const svg = d3.select('#treeSvg');
  const g = svg.select('g.zoom-group');
  
  // Update node positions
  g.selectAll('.node')
    .attr('transform', d => {
      const node = state.nodes.find(n => n.id === d.id);
      if (node) {
        return `translate(${node.x}, ${node.y})`;
      }
      return `translate(${d.x}, ${d.y})`;
    });
  
  // Update link paths
  g.selectAll('.link-group').each(function(linkData) {
    const group = d3.select(this);
    const source = state.nodes.find(n => n.id === linkData.child_id);
    const target = state.nodes.find(n => n.id === linkData.parent_id);
    
    if (source && target) {
      // Update the path
      group.select('path.link')
        .attr('d', calculateLinkPath(source, target));
      
      // Update the label position
      const midX = (source.x + target.x) / 2;
      const midY = (source.y + target.y) / 2 - 15;
      group.select('.link-label-group')
        .attr('transform', `translate(${midX}, ${midY})`);
    }
  });
}

function getNodeWithChildren(nodeId) {
  const result = [];
  const visited = new Set();
  
  function traverse(id) {
    if (visited.has(id)) return;
    visited.add(id);
    
    const node = state.nodes.find(n => n.id === id);
    if (node) {
      result.push(node);
      node.receivesFrom.forEach(childId => traverse(childId));
    }
  }
  
  traverse(nodeId);
  return result;
}

// ============================================================
// FORCE SIMULATION
// ============================================================
function setupForceSimulation(visibleNodes, visibleLinks) {
  // Transform links to D3 format (source/target instead of child_id/parent_id)
  const d3Links = visibleLinks.map(link => ({
    source: link.child_id,
    target: link.parent_id,
    ...link
  }));
  
  const sim = d3.forceSimulation(visibleNodes)
    .force('link', d3.forceLink(d3Links)
      .id(d => d.id)
      .distance(150)
      .strength(0.3))
    .force('charge', d3.forceManyBody().strength(-300))
    .force('collide', d3.forceCollide().radius(d => Math.max(d.width, d.height) / 2 + 20))
    .alphaDecay(0.02)
    .on('tick', () => {
      d3.selectAll('.node')
        .attr('transform', d => `translate(${d.x}, ${d.y})`);
      
      // Update links with curved paths
      d3.selectAll('.link-group').each(function(linkData) {
        const source = visibleNodes.find(n => n.id === linkData.child_id);
        const target = visibleNodes.find(n => n.id === linkData.parent_id);
        if (!source || !target) return;
        
        // Use curved Bezier path
        d3.select(this).select('.link')
          .attr('d', calculateLinkPath(source, target));
        
        // Update label positions at midpoint
        const midX = (source.x + target.x) / 2;
        const midY = (source.y + target.y) / 2;
        
        // Get label background and adjust position
        const labelBg = d3.select(this).select('.link-label-bg');
        if (!labelBg.empty()) {
          const bgWidth = parseFloat(labelBg.attr('width')) || 50;
          const bgHeight = parseFloat(labelBg.attr('height')) || 16;
          labelBg
            .attr('x', midX - bgWidth / 2)
            .attr('y', midY - bgHeight / 2);
        }
        
        // Update all label text positions
        const labels = d3.select(this).selectAll('.link-label');
        const labelCount = labels.size();
        const lineHeight = 11;
        const totalHeight = labelCount * lineHeight + 6;
        
        labels.each(function(d, i) {
          d3.select(this)
            .attr('x', midX)
            .attr('y', midY - totalHeight / 2 + 10 + (i * lineHeight));
        });
      });
    });
  
  state.setSimulation(sim);
}

// ============================================================
// COLLAPSE/EXPAND
// ============================================================
function toggleCollapse(nodeId) {
  state.toggleCollapsedNode(nodeId);
  renderGraph();
}

export function expandAll() {
  state.clearCollapsedNodes();
  renderGraph();
}

export function collapseAll() {
  state.nodes.forEach(n => {
    if (n.receivesFrom.length > 0) {
      state.collapsedNodes.add(n.id);
    }
  });
  renderGraph();
}

// ============================================================
// CONTEXT MENUS
// ============================================================
function showNodeContextMenu(x, y, node) {
  const menu = document.getElementById('contextMenu');
  
  // Check if node is an orphan or can be connected to more parents
  const canConnect = state.nodes.some(n => 
    n.id !== node.id && !node.goesInto.includes(n.id)
  );
  
  // Get outgoing links (this node as child → parents)
  const outgoingLinks = state.links.filter(l => l.child_id === node.id);
  const hasOutgoingLinks = outgoingLinks.length > 0;
  
  menu.innerHTML = `
    <div class="context-menu-item" onclick="window.openNodeEditPanel('${node.id}')">
      <span class="context-menu-icon">✏️</span> Edit Node
    </div>
    <div class="context-menu-item" onclick="window.addChildNode('${node.id}')">
      <span class="context-menu-icon">➕</span> Add Child
    </div>
    ${canConnect ? `
    <div class="context-menu-item" onclick="window.showConnectNodeMenu('${node.id}')">
      <span class="context-menu-icon">🔗</span> Connect to Parent
    </div>
    ` : ''}
    ${hasOutgoingLinks ? `
    <div class="context-menu-divider"></div>
    <div class="context-menu-item" onclick="window.showNodeLinksPanel('${node.id}')">
      <span class="context-menu-icon">🔩</span> Edit Links (${outgoingLinks.length})
    </div>
    ` : ''}
    <div class="context-menu-divider"></div>
    <div class="context-menu-item" onclick="window.toggleNodeLock('${node.id}')">
      <span class="context-menu-icon">${state.lockedNodes.has(node.id) ? '🔓' : '🔒'}</span> 
      ${state.lockedNodes.has(node.id) ? 'Unlock Position' : 'Lock Position'}
    </div>
    <div class="context-menu-divider"></div>
    <div class="context-menu-item danger" onclick="window.confirmDeleteNode('${node.id}')">
      <span class="context-menu-icon">🗑️</span> Delete Node
    </div>
  `;
  
  menu.style.left = x + 'px';
  menu.style.top = y + 'px';
  menu.classList.add('show');
}

// Show all outgoing links for a node in side panel
function showNodeLinksPanel(nodeId) {
  hideContextMenu();
  
  const node = state.nodes.find(n => n.id === nodeId);
  if (!node) return;
  
  // Get all outgoing links (this node → parents)
  const outgoingLinks = state.links.filter(l => l.child_id === nodeId);
  
  if (outgoingLinks.length === 0) {
    showToast('No outgoing links', 'info');
    return;
  }
  
  let linksHtml = outgoingLinks.map(link => {
    const parent = state.nodes.find(n => n.id === link.parent_id);
    return `
      <div class="link-item" style="padding:12px;border:1px solid #e0e0e0;border-radius:8px;margin-bottom:10px;cursor:pointer;transition:all 0.2s;"
           onclick="window.editLinkFastener('${link.id}')"
           onmouseover="this.style.background='#f5f5f5';this.style.borderColor='#3498db';"
           onmouseout="this.style.background='white';this.style.borderColor='#e0e0e0';">
        <div style="font-weight:600;margin-bottom:5px;">→ ${escapeHtml(parent?.name || 'Unknown')}</div>
        <div style="font-size:12px;color:#666;">
          ${link.fastener ? `<span style="color:#3498db;">🔩 ${escapeHtml(link.fastener)}${link.qty > 1 ? ' ×' + link.qty : ''}</span>` : '<span style="color:#999;">No fastener</span>'}
          ${link.loctite ? `<br><span style="color:#9b59b6;">🧴 LT-${link.loctite}</span>` : ''}
          ${link.torque_value ? `<br><span style="color:#e67e22;">🔧 ${link.torque_value}${link.torque_unit || 'Nm'}</span>` : ''}
        </div>
      </div>
    `;
  }).join('');
  
  const content = `
    <p style="margin-bottom:15px;color:#666;font-size:13px;">
      Links from <strong>${escapeHtml(node.name)}</strong> to parent nodes:
    </p>
    <div class="links-list">
      ${linksHtml}
    </div>
    <p style="margin-top:15px;font-size:11px;color:#888;">
      💡 Click on a link to edit its properties
    </p>
  `;
  
  setSidePanelContent(`Links (${outgoingLinks.length})`, content, [
    { label: 'Close', class: 'btn-secondary', action: closeSidePanel }
  ]);
  
  openSidePanel();
}

window.showNodeLinksPanel = showNodeLinksPanel;

function showLinkContextMenu(x, y, link) {
  const menu = document.getElementById('contextMenu');
  
  menu.innerHTML = `
    <div class="context-menu-item" onclick="window.editLinkFastener('${link.id}')">
      <span class="context-menu-icon">🔧</span> Edit Fastener
    </div>
    <div class="context-menu-divider"></div>
    <div class="context-menu-item danger" onclick="window.confirmDeleteLink('${link.id}')">
      <span class="context-menu-icon">🗑️</span> Delete Link
    </div>
  `;
  
  menu.style.left = x + 'px';
  menu.style.top = y + 'px';
  menu.classList.add('show');
}

// ============================================================
// NODE EDIT PANEL
// ============================================================
function openNodeEditPanel(node) {
  if (typeof node === 'string') {
    node = state.nodes.find(n => n.id === node);
  }
  if (!node) return;
  
  const content = `
    <div class="form-group">
      <label class="form-label">Name</label>
      <input type="text" class="form-input" id="nodeEditName" value="${escapeHtml(node.name || '')}">
    </div>
    <div class="form-group">
      <label class="form-label">Part Number</label>
      <input type="text" class="form-input" id="nodeEditPN" value="${escapeHtml(node.part_number || '')}">
    </div>
    <div class="form-row">
      <div class="form-group">
        <label class="form-label">Status</label>
        <select class="form-select" id="nodeEditStatus">
          <option value="NOT_STARTED" ${node.status === 'NOT_STARTED' ? 'selected' : ''}>Not Started</option>
          <option value="IN_PROGRESS" ${node.status === 'IN_PROGRESS' ? 'selected' : ''}>In Progress</option>
          <option value="DONE" ${node.status === 'DONE' ? 'selected' : ''}>Done</option>
          <option value="BLOCKED" ${node.status === 'BLOCKED' ? 'selected' : ''}>Blocked</option>
          <option value="ON_HOLD" ${node.status === 'ON_HOLD' ? 'selected' : ''}>On Hold</option>
          <option value="REVIEW" ${node.status === 'REVIEW' ? 'selected' : ''}>Review</option>
        </select>
      </div>
      <div class="form-group">
        <label class="form-label">Qty</label>
        <input type="number" class="form-input" id="nodeEditQty" value="${node.qty || 1}" min="1">
      </div>
    </div>
    <div class="form-row">
      <div class="form-group">
        <label class="form-label">Group</label>
        <input type="number" class="form-input" id="nodeEditGroup" value="${node.group_num || 0}" min="0">
      </div>
      <div class="form-group">
        <label class="form-label">Sequence</label>
        <input type="number" class="form-input" id="nodeEditSeq" value="${node.sequence_num || 0}" min="0">
      </div>
    </div>
    <div class="form-group">
      <label class="form-label">Notes</label>
      <textarea class="form-textarea" id="nodeEditNotes">${escapeHtml(node.notes || '')}</textarea>
    </div>
    <div class="form-group">
      <label class="form-label">Level: L${node.level}</label>
    </div>
  `;
  
  setSidePanelContent('Edit Node', content, [
    { label: 'Cancel', class: 'btn-secondary', action: closeSidePanel },
    { label: 'Save', class: 'btn-primary', action: () => saveNodeEdit(node.id) }
  ]);
  
  openSidePanel();
}

async function saveNodeEdit(nodeId) {
  const updates = {
    name: document.getElementById('nodeEditName').value.trim(),
    part_number: document.getElementById('nodeEditPN').value.trim() || null,
    status: document.getElementById('nodeEditStatus').value,
    qty: parseInt(document.getElementById('nodeEditQty').value) || 1,
    group_num: parseInt(document.getElementById('nodeEditGroup').value) || 0,
    sequence_num: parseInt(document.getElementById('nodeEditSeq').value) || 0,
    notes: document.getElementById('nodeEditNotes').value.trim() || null,
    updated_at: new Date().toISOString()
  };
  
  if (!updates.name) {
    showToast('Name is required', 'error');
    return;
  }
  
  try {
    const { error } = await db.from('logi_nodes').update(updates).eq('id', nodeId);
    if (error) throw error;
    
    closeSidePanel();
    showToast('Node updated', 'success');
    await loadAssemblyData(state.currentAssemblyId);
  } catch (e) {
    console.error('Error saving node:', e);
    showToast('Failed to save node', 'error');
  }
}

// ============================================================
// EXPORTS TO WINDOW
// ============================================================
window.openNodeEditPanel = openNodeEditPanel;
window.renderGraph = renderGraph;
window.expandAll = expandAll;
window.collapseAll = collapseAll;

export { calculateLevels, getNodeColor, isNodeVisible, drawShape };
