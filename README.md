# Logi Assembly v28

A hierarchical assembly tree visualization tool for elevator mechanical assemblies.

## Features

- **Multi-level hierarchy**: Projects → Assemblies → Tree visualization
- **Dynamic level calculation**: L1 (root/final product) → L8+ (unlimited depth)
- **Per-level styling**: Different shapes, colors, font sizes, and weights for each level
- **Interactive D3.js visualization**: Force simulation, drag-drop, collapse/expand
- **Admin/Guest roles**: Full editing vs view-only access
- **Export**: PNG and SVG download
- **Chatbot Assistant**: AI-powered assembly analysis and suggestions

## New in v28

### Visual Improvements

| Feature | v27 | v28 |
|---------|-----|-----|
| Border width | 2-3px (thick) | 1.5px (clean) |
| Arrow style | Corner bezier | Smooth edge-center bezier |
| Arrowhead | 6px (clips) | 5px (proper offset) |
| Status indicator | None | Colored dot (top-left) |
| Font sizes | 18-10px | 14-10px (smaller) |

### Collapse All Descendants

When you collapse a node, **ALL descendants** are now hidden (not just immediate children).

### Status Indicator Dots

Each node shows a colored dot in the top-left corner:
- ✅ Done = Green
- 🔄 In Progress = Orange  
- 🚫 Blocked = Red
- ⬜ Not Started = Gray

### Smooth Bezier Arrows

- Connections from edge centers (not corners)
- Gentle S-curves using cubic bezier
- Smart edge detection based on relative position
- Smaller, non-clipping arrowheads

## Deployment

Push to GitHub and enable GitHub Pages in repository settings.

## Credits

Built with D3.js, Supabase, and Google Sign-In.
