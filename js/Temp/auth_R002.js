// ============================================================
// Logi Assembly v27 - Authentication Module
// ============================================================

import { GOOGLE_CLIENT_ID, ADMIN_EMAIL } from './config.js';
import * as state from './state.js';
import { showToast, showAdminUI, showGuestUI, hideAdminUI, showModal, hideModal } from './ui.js';
import { loadProjects } from './projects.js';
import { loadAssembliesForProject } from './assemblies.js';

// ============================================================
// GOOGLE SIGN-IN INITIALIZATION
// ============================================================
export function initGoogleSignIn() {
  if (typeof google === 'undefined' || !google.accounts) {
    console.log('Google Sign-In not loaded yet, retrying...');
    setTimeout(initGoogleSignIn, 500);
    return;
  }
  
  google.accounts.id.initialize({
    client_id: GOOGLE_CLIENT_ID,
    callback: handleGoogleCallback,
    auto_select: true,
  });
  
  // Check if user was previously logged in
  const savedEmail = localStorage.getItem('logi_admin_email');
  if (savedEmail === ADMIN_EMAIL) {
    // Try to auto-login
    google.accounts.id.prompt();
  }
}

// ============================================================
// GOOGLE CALLBACK
// ============================================================
function handleGoogleCallback(response) {
  const payload = decodeJwtPayload(response.credential);
  
  if (payload && payload.email) {
    state.setGoogleUser(payload);
    
    if (payload.email.toLowerCase() === ADMIN_EMAIL.toLowerCase()) {
      state.setIsAdmin(true);
      localStorage.setItem('logi_admin_email', payload.email);
      showAdminUI(payload);
      showToast(`Welcome, ${payload.name || 'Admin'}!`, 'success');
      console.log('Admin logged in, isAdmin =', state.isAdmin);
    } else {
      state.setIsAdmin(false);
      showToast('Logged in as guest (view only)', 'info');
      showGuestUI(payload);
    }
    
    // RELOAD data from DB to get correct visibility-filtered results
    console.log('Reloading data for page:', state.currentPage, 'isAdmin:', state.isAdmin);
    if (state.currentPage === 'home') {
      loadProjects();
    } else if (state.currentPage === 'assemblies' && state.currentProject) {
      loadAssembliesForProject(state.currentProject.id);
    }
  }
}

// ============================================================
// JWT DECODE
// ============================================================
function decodeJwtPayload(token) {
  try {
    const base64Url = token.split('.')[1];
    const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
    const jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
      return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
    }).join(''));
    return JSON.parse(jsonPayload);
  } catch (e) {
    console.error('Failed to decode JWT:', e);
    return null;
  }
}

// ============================================================
// LOGIN HANDLER
// ============================================================
export function handleLogin() {
  if (typeof google === 'undefined' || !google.accounts) {
    showToast('Google Sign-In not loaded. Please refresh.', 'error');
    return;
  }
  
  // Re-initialize Google Sign-In to ensure it works after logout
  google.accounts.id.initialize({
    client_id: GOOGLE_CLIENT_ID,
    callback: handleGoogleCallback,
    auto_select: false,
  });
  
  // Show Google Sign-In prompt
  google.accounts.id.prompt((notification) => {
    if (notification.isNotDisplayed() || notification.isSkippedMoment()) {
      showGoogleButtonFallback();
    }
  });
}

// ============================================================
// FALLBACK SIGN-IN BUTTON
// ============================================================
function showGoogleButtonFallback() {
  showModal(
    'Sign In',
    '<div id="googleButtonContainer" style="display:flex;justify-content:center;padding:20px;"></div>',
    [{ label: 'Cancel', class: 'btn-secondary', action: hideModal }]
  );
  
  setTimeout(() => {
    const container = document.getElementById('googleButtonContainer');
    if (container && google.accounts.id) {
      google.accounts.id.renderButton(container, {
        theme: 'outline',
        size: 'large',
        text: 'signin_with',
        shape: 'rectangular'
      });
    }
  }, 100);
}

// ============================================================
// LOGOUT HANDLER
// ============================================================
export function handleLogout() {
  state.setIsAdmin(false);
  state.setGoogleUser(null);
  localStorage.removeItem('logi_admin_email');
  
  if (typeof google !== 'undefined' && google.accounts) {
    google.accounts.id.disableAutoSelect();
  }
  
  hideAdminUI();
  showToast('Logged out', 'info');
  
  // Re-render current page to remove admin content and hidden items
  if (state.currentPage === 'home') {
    loadProjects();
  } else if (state.currentPage === 'assemblies' && state.currentProject) {
    loadAssembliesForProject(state.currentProject.id);
  }
}

// ============================================================
// CHECK ADMIN STATUS
// ============================================================
export function checkAdminStatus() {
  // Don't set isAdmin from localStorage alone - wait for actual Google sign-in
  state.setIsAdmin(false);
  initGoogleSignIn();
}
