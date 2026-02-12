// ============================================================
// Logi Assembly v27 - Export Module
// ============================================================

import {
  LEVEL_COLORS, LEVEL_SHAPES, LEVEL_FONT_SIZES, LEVEL_FONT_WEIGHTS,
  FASTENER_COLORS
} from './config.js';
import * as state from './state.js';
import { showToast, closeAllDropdowns } from './ui.js';

// ============================================================
// DOWNLOAD PNG
// ============================================================
export async function downloadPNG() {
  closeAllDropdowns();
  
  const svg = document.getElementById('treeSvg');
  if (!svg) return;
  
  showToast('Generating PNG...', 'info');
  
  try {
    // Clone SVG
    const clone = svg.cloneNode(true);
    
    // Embed styles
    const styleElement = document.createElementNS('http://www.w3.org/2000/svg', 'style');
    styleElement.textContent = getEmbeddedStyles();
    clone.insertBefore(styleElement, clone.firstChild);
    
    // Add white background
    const bg = document.createElementNS('http://www.w3.org/2000/svg', 'rect');
    bg.setAttribute('width', '100%');
    bg.setAttribute('height', '100%');
    bg.setAttribute('fill', 'white');
    clone.insertBefore(bg, clone.firstChild);
    
    // Serialize
    const serializer = new XMLSerializer();
    const svgString = serializer.serializeToString(clone);
    const svgBlob = new Blob([svgString], { type: 'image/svg+xml;charset=utf-8' });
    const url = URL.createObjectURL(svgBlob);
    
    // Create image
    const img = new Image();
    img.onload = () => {
      const canvas = document.createElement('canvas');
      const scale = 2; // Higher resolution
      canvas.width = svg.clientWidth * scale;
      canvas.height = svg.clientHeight * scale;
      
      const ctx = canvas.getContext('2d');
      ctx.scale(scale, scale);
      ctx.fillStyle = 'white';
      ctx.fillRect(0, 0, canvas.width, canvas.height);
      ctx.drawImage(img, 0, 0);
      
      // Download
      canvas.toBlob(blob => {
        const a = document.createElement('a');
        a.href = URL.createObjectURL(blob);
        a.download = `${state.currentAssemblyName || 'assembly'}_tree.png`;
        a.click();
        URL.revokeObjectURL(a.href);
        showToast('PNG downloaded', 'success');
      }, 'image/png');
      
      URL.revokeObjectURL(url);
    };
    
    img.onerror = () => {
      showToast('Failed to generate PNG', 'error');
      URL.revokeObjectURL(url);
    };
    
    img.src = url;
  } catch (e) {
    console.error('Error generating PNG:', e);
    showToast('Failed to generate PNG', 'error');
  }
}

// ============================================================
// DOWNLOAD SVG
// ============================================================
export function downloadSVG() {
  closeAllDropdowns();
  
  const svg = document.getElementById('treeSvg');
  if (!svg) return;
  
  try {
    // Clone SVG
    const clone = svg.cloneNode(true);
    
    // Embed styles
    const styleElement = document.createElementNS('http://www.w3.org/2000/svg', 'style');
    styleElement.textContent = getEmbeddedStyles();
    clone.insertBefore(styleElement, clone.firstChild);
    
    // Add white background
    const bg = document.createElementNS('http://www.w3.org/2000/svg', 'rect');
    bg.setAttribute('width', '100%');
    bg.setAttribute('height', '100%');
    bg.setAttribute('fill', 'white');
    clone.insertBefore(bg, clone.firstChild);
    
    // Serialize and download
    const serializer = new XMLSerializer();
    const svgString = serializer.serializeToString(clone);
    const blob = new Blob([svgString], { type: 'image/svg+xml;charset=utf-8' });
    
    const a = document.createElement('a');
    a.href = URL.createObjectURL(blob);
    a.download = `${state.currentAssemblyName || 'assembly'}_tree.svg`;
    a.click();
    URL.revokeObjectURL(a.href);
    
    showToast('SVG downloaded', 'success');
  } catch (e) {
    console.error('Error generating SVG:', e);
    showToast('Failed to generate SVG', 'error');
  }
}

// ============================================================
// EMBEDDED STYLES FOR EXPORT
// ============================================================
function getEmbeddedStyles() {
  // Build font size CSS for each level
  const fontSizeStyles = LEVEL_FONT_SIZES.map((size, i) => 
    `.node[data-level="${i+1}"] .node-label { font-size: ${size}px; font-weight: ${LEVEL_FONT_WEIGHTS[i]}; }`
  ).join('\n');
  
  return `
    text {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    .node-label {
      font-weight: 500;
      fill: #333;
    }
    .node-pn {
      fill: #666;
      font-style: italic;
      font-size: 7px;
    }
    .link {
      fill: none;
      stroke-linecap: round;
    }
    .link-label {
      font-size: 8px;
      font-weight: 600;
    }
    .link-label-bg {
      fill: white;
      opacity: 0.95;
    }
    .sequence-badge {
      font-size: 11px;
      font-weight: bold;
      fill: #e74c3c;
    }
    .toggle-icon {
      font-size: 10px;
      font-weight: bold;
      fill: #333;
    }
    .lock-indicator {
      font-size: 10px;
    }
    .collapse-indicator {
      fill: #ffffff;
      stroke: #333;
      stroke-width: 1.5px;
    }
    ${fontSizeStyles}
  `;
}

// ============================================================
// EXPORTS TO WINDOW
// ============================================================
window.downloadPNG = downloadPNG;
window.downloadSVG = downloadSVG;
