# Logi Assembly v27

A hierarchical assembly tree visualization tool for elevator mechanical assemblies.

## Features

- **Multi-level hierarchy**: Projects → Assemblies → Tree visualization
- **Dynamic level calculation**: L1 (root/final product) → L8+ (unlimited depth)
- **Per-level styling**: Different shapes, colors, font sizes, and weights for each level
- **Interactive D3.js visualization**: Force simulation, drag-drop, collapse/expand
- **Admin/Guest roles**: Full editing vs view-only access
- **Export**: PNG and SVG download

## New in v27

### Level-Based Font Sizing (Option C: Moderate)

| Level | Font Size | Font Weight | Shape | Color |
|-------|-----------|-------------|-------|-------|
| L1 | 18px | 700 (Bold) | Stadium | Green |
| L2 | 16px | 600 | Octagon | Purple |
| L3 | 15px | 600 | Hexagon | Light Blue |
| L4 | 14px | 500 | Pentagon | Light Green |
| L5 | 13px | 500 | Diamond | Yellow |
| L6 | 12px | 400 | Rounded Rect | Orange |
| L7 | 11px | 400 | Rectangle | Pink |
| L8+ | 10px | 400 | Parallelogram | Gray |

### Modular ES6 Architecture

The codebase is now split into multiple files for better maintainability:

```
logi-assembly/
├── index.html          # Main HTML structure
├── css/
│   └── styles.css      # All CSS styles
└── js/
    ├── config.js       # Constants, colors, shapes, fonts
    ├── database.js     # Supabase connection
    ├── state.js        # Shared application state
    ├── auth.js         # Google Sign-In authentication
    ├── ui.js           # UI utilities (toast, modal, navigation)
    ├── projects.js     # Project CRUD operations
    ├── assemblies.js   # Assembly CRUD operations
    ├── graph.js        # D3.js visualization & rendering
    ├── nodes.js        # Node operations (add, delete, lock)
    ├── links.js        # Link operations (fasteners)
    ├── export.js       # PNG/SVG export
    └── app.js          # Main initialization & event listeners
```

## Deployment

### GitHub Pages

1. Push the `logi-assembly` folder to your GitHub repository
2. Enable GitHub Pages in repository settings
3. The app will be available at `https://[username].github.io/[repo]/`

### Local Development

Since we use ES6 modules (`type="module"`), you need a local server:

```bash
# Using Python
python -m http.server 8000

# Using Node.js
npx serve

# Using PHP
php -S localhost:8000
```

Then open `http://localhost:8000` in your browser.

## Configuration

Edit `js/config.js` to customize:

- `SUPABASE_URL` and `SUPABASE_ANON_KEY` - Database connection
- `GOOGLE_CLIENT_ID` - Google OAuth client ID
- `ADMIN_EMAIL` - Admin user email
- `LEVEL_COLORS` - Colors for each level
- `LEVEL_SHAPES` - Shapes for each level
- `LEVEL_FONT_SIZES` - Font sizes for each level
- `LEVEL_FONT_WEIGHTS` - Font weights for each level

## Level Logic

- **L1** = Root nodes (final product, no parents)
- **L2** = Direct children of L1
- **L3** = Children of L2
- **L4, L5, L6...** = Continue increasing, no ceiling
- **L8+** = All levels 8 and above use L8 styling (gray parallelogram)

## Browser Support

- Chrome (recommended)
- Firefox
- Safari
- Edge

## Credits

Built with:
- [D3.js](https://d3js.org/) - Visualization
- [Supabase](https://supabase.com/) - Backend database
- [Google Sign-In](https://developers.google.com/identity) - Authentication
