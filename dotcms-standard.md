# dotCMS proposed standards:

- Site: Start fresh and create a new site domain, do not use the demo site.
- Use VTL Includes: When your widget is going in an VTL file, use a VTL include instead of creating a simple widget.
- Naming Prefixes: dotCMS components developed (Structures, Widgets, Containers, Templates) should have a short prefix to keep our code grouped together, easily identifiable, and distinguishable from built-in components. Ideally a project or client name prefix usually works well.
- Widget and Structure Naming: Use a prefix followed by the entities context, purpose, and usage.
  - WorldatWork Examples: 
    - Content: WAW Sub Nav
    - Widget: WAW CTA Callout Message Widget
- Velocity Variable Naming: Use functional context based naming. Velocity has no scope, so using unique naming between scripts will save headaches and collisions.
- Theme Scripts: Template designer developed templates require theme files to work. The base theme folder should only contain the VTL scripts necessary for the theme to work. Assets should be located elsewhere.
  - Required Theme Folder: `/application/themes/themeName`
  - Required Theme Files: 
    - `template.vtl` (core template scripting)
    - `html_head.vtl` (Everything inside <head></head>)
    - `header.vtl` (Page Header)
    - `footer.vtl` (Page Footer)
  - Optional Theme files: 
    - `nav.vtl` (Navigation Menu)
    - `bottom.vtl` (Back and Front-end Scripting to be placed below </body>)
- Assets Location (JS/CSS/SASS/Fonts/Images/etc): Should be kept outside of the /application folder.
  - Proposed flat Structure:
    - `/css`
      `/sass`
      `/js`
      `/fonts`
      `/img`
- 
- VTL File Location: All VTL scripts should be centrally located in `/application/vtl`
- Containers(*): Should be layout oriented, with a prefix, it's layout type and behaviour. Wrapper CSS classes should be included in the description.
  - Containers using a structure that relies on Velocity, should use a `#dotParse()` - in case of multiple containers that may use this scripting won't have to be placed all over and adjustments will be global.
    - These files should be located in `/application/vtl/containers`
  - Containers should be as general-purpose as possible to avoid bloat and one-offs.
- Macro Files: Should be prefixed with `macro-name.vm` to distinguish from the rest of the velocity scripts and grouped.
  - Macro files should be placed in a zero-content container with the list of `#dotParse()`'s. This container should be added to:
    - Theme files: Place `#parseContainer()` in `template.vtl` at the top below the `preprocess.vl`
    - Advanced Template: Place `#parseContainer()` at the top.
- Velocity Heading Format
```
#* WIDGET NAME
 * @version: 0.10
 * @author: 
 *
 * Required Widget Params: 
 *
 * Widget Object:  
 * Widget Vars:    
*#
```
- Velocity Code Styling (Not today)
