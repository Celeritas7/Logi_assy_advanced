// ============================================================
// Logi Assembly v29 - Main Application
// ============================================================

import { db, testConnection, updateDbIndicator } from './database.js';
import * as state from './state.js';
import {
  showToast, navigateTo, navigateBack, hideContextMenu, closeAllDropdowns,
  toggleExportDropdown, toggleLockDropdown, closeLockDropdown, updateUndoButton
} from './ui.js';
import { checkAdminStatus, handleLogin, handleLogout } from './auth.js';
import { loadProjects } from './projects.js';
import {
  loadAssemblies, createNewAssemblyInTree, renameAssembly,
  confirmDeleteAssembly, duplicateAssembly
} from './assemblies.js';
import { loadAssemblyData, renderGraph, expandAll, collapseAll } from './graph.js';
import {
  showAddRootNodeMenu, lockAllVisibleNodes, unlockAllNodes,
  saveAllPositions, undoPositions, refreshUnlockedNodes
} from './nodes.js';
import './links.js'; // Import for side effects (window exports)
import { downloadPNG, downloadSVG, showExportOptions } from './export.js';
import './chatbot.js'; // Import chatbot for side effects (window exports)
import './import.js'; // CSV import functionality

// ============================================================
// INITIALIZATION
// ============================================================
async function init() {
  console.log('Logi Assembly v29 initializing...');
  
  // Test database connection
  const connected = await testConnection();
  updateDbIndicator(connected);
  
  if (!connected) {
    showToast('Database connection failed', 'error');
  }
  
  // Setup event listeners
  setupEventListeners();
  
  // Check admin status (will trigger Google Sign-In)
  checkAdminStatus();
  
  // Load projects
  await loadProjects();
  
  // Navigate to home
  navigateTo('home');
  
  console.log('Logi Assembly v29 ready');
}

// ============================================================
// EVENT LISTENERS
// ============================================================
function setupEventListeners() {
  // Assembly dropdown change
  document.getElementById('assemblySelect').addEventListener('change', async (e) => {
    const assemblyId = e.target.value;
    if (assemblyId) {
      const assembly = state.assemblies.find(a => a.id === assemblyId);
      state.setCurrentAssembly(assemblyId, assembly?.name || '');
      await loadAssemblyData(assemblyId);
    }
  });
  
  // Level filter change
  document.getElementById('levelFilter').addEventListener('change', (e) => {
    state.setLevelFilter(e.target.value);
    renderGraph();
  });
  
  // Color mode change
  document.getElementById('colorMode').addEventListener('change', (e) => {
    state.setColorMode(e.target.value);
    renderGraph();
  });
  
  // Layout mode change
  document.getElementById('layoutMode').addEventListener('change', (e) => {
    state.setLayoutMode(e.target.value);
    renderGraph();
  });
  
  // Keyboard events
  document.addEventListener('keydown', (e) => {
    if (e.key === 'Shift') {
      state.setShiftKeyPressed(true);
    }
    
    // Escape to close menus/panels
    if (e.key === 'Escape') {
      hideContextMenu();
      closeAllDropdowns();
    }
  });
  
  document.addEventListener('keyup', (e) => {
    if (e.key === 'Shift') {
      state.setShiftKeyPressed(false);
    }
  });
  
  // Click outside to close menus
  document.addEventListener('click', (e) => {
    // Close context menu
    if (!e.target.closest('.context-menu')) {
      hideContextMenu();
    }
    
    // Close dropdowns
    if (!e.target.closest('.dropdown')) {
      closeAllDropdowns();
    }
  });
  
  // Right-click on tree container
  document.getElementById('treeContainer').addEventListener('contextmenu', (e) => {
    if (!state.isAdmin) return;
    if (state.currentPage !== 'tree') return;
    
    // Only show menu if clicking on empty space
    if (e.target.tagName === 'svg' || e.target.closest('svg') && !e.target.closest('.node') && !e.target.closest('.link-group')) {
      e.preventDefault();
      
      // Get SVG coordinates
      const svg = document.getElementById('treeSvg');
      const rect = svg.getBoundingClientRect();
      const x = e.clientX - rect.left;
      const y = e.clientY - rect.top;
      
      showAddRootNodeMenu(e.clientX, e.clientY, x, y);
    }
  });
  
  // Window resize
  window.addEventListener('resize', () => {
    if (state.currentPage === 'tree' && state.nodes.length > 0) {
      renderGraph();
    }
  });
}

// ============================================================
// EXPORT FUNCTIONS TO WINDOW
// ============================================================

// Navigation
window.navigateTo = navigateTo;
window.navigateBack = navigateBack;

// Auth
window.handleLogin = handleLogin;
window.handleLogout = handleLogout;

// Assembly actions (for header buttons)
window.createNewAssemblyInTree = createNewAssemblyInTree;
window.renameAssembly = renameAssembly;
window.confirmDeleteAssembly = confirmDeleteAssembly;
window.duplicateAssembly = duplicateAssembly;

// Tree controls
window.refreshUnlockedNodes = refreshUnlockedNodes;
window.expandAll = expandAll;
window.collapseAll = collapseAll;
window.undoPositions = undoPositions;
window.saveAllPositions = saveAllPositions;

// Lock controls
window.toggleLockDropdown = toggleLockDropdown;
window.closeLockDropdown = closeLockDropdown;
window.lockAllVisibleNodes = lockAllVisibleNodes;
window.unlockAllNodes = unlockAllNodes;

// Export controls
window.toggleExportDropdown = toggleExportDropdown;
window.downloadPNG = () => showExportOptions('png');
window.downloadSVG = () => showExportOptions('svg');

// Sequence number toggle
window.toggleSequenceNumbers = function() {
  state.setShowSequenceNumbers(!state.showSequenceNumbers);
  const btn = document.getElementById('seqToggleBtn');
  if (btn) {
    btn.style.background = state.showSequenceNumbers ? '#3498db' : '#95a5a6';
    btn.title = state.showSequenceNumbers ? 'Hide Sequence Numbers' : 'Show Sequence Numbers';
  }
  renderGraph();
  showToast(`Sequence numbers ${state.showSequenceNumbers ? 'visible' : 'hidden'}`, 'info');
};

// Level headers toggle
window.toggleLevelHeaders = function() {
  state.setShowLevelHeaders(!state.showLevelHeaders);
  const btn = document.getElementById('levelToggleBtn');
  if (btn) {
    btn.style.background = state.showLevelHeaders ? '#3498db' : '#95a5a6';
    btn.title = state.showLevelHeaders ? 'Hide Level Headers' : 'Show Level Headers';
  }
  renderGraph();
  showToast(`Level headers ${state.showLevelHeaders ? 'visible' : 'hidden'}`, 'info');
};

// Separator lines toggle
window.toggleSeparatorLines = function() {
  state.setShowSeparatorLines(!state.showSeparatorLines);
  const btn = document.getElementById('separatorToggleBtn');
  if (btn) {
    btn.style.background = state.showSeparatorLines ? '#3498db' : '#95a5a6';
    btn.title = state.showSeparatorLines ? 'Hide Group Separators' : 'Show Group Separators';
  }
  renderGraph();
  showToast(`Separator lines ${state.showSeparatorLines ? 'visible' : 'hidden'}`, 'info');
};

// Layout mode toggle (Force / Tree)
window.setLayoutMode = function(mode) {
  state.setLayoutMode(mode);
  
  // Update button states
  const forceBtn = document.getElementById('forceLayoutBtn');
  const treeBtn = document.getElementById('treeLayoutBtn');
  
  if (forceBtn && treeBtn) {
    forceBtn.classList.toggle('active', mode === 'force');
    treeBtn.classList.toggle('active', mode === 'tree');
  }
  
  // Show/hide force-only controls
  const forceOnlyControls = ['refreshBtn', 'expandBtn', 'collapseBtn'];
  forceOnlyControls.forEach(id => {
    const el = document.getElementById(id);
    if (el) {
      el.style.display = mode === 'tree' ? 'none' : '';
    }
  });
  
  renderGraph();
  showToast(`Layout: ${mode === 'force' ? 'Force' : 'Tree'}`, 'info');
};

// Side panel
window.closeSidePanel = () => {
  document.getElementById('sidePanel').classList.remove('open');
};

// ============================================================
// START APPLICATION
// ============================================================
document.addEventListener('DOMContentLoaded', init);
