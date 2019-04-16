# dotCMS front-end development Guidelines

## Directory Structure

```
webroot.com           Site Root
+ application         Main "Middleware" Files
| |- apivtl           dotCMS Velocity REST API files
| |- async            Velocity files that used in pages that return JSON/XML/HTML segments
| |- containers       dotCMS File-based container files
| |- content-types    General VTL files for specific Content Types (legacy container support)
| |- custom-fields    Files for use in custom fields
| |- includes         General Basic includes (VTL, JSON, XML, etc)
| |- macros           All macro `.vm` files
| |- themes           Standard theme directory
| |  + default        Standard theme
| |- util             Utility files for internal use
| |- vtl              General VTL storage
| +- widgets          VTLs used in widget directly
|                     
|- css                Site CSS
|- documents          Public facing File Assets
|- downloads          Public facing File Assets
|- fonts              Site Fonts
|- img                Site Images
|  + icons            Icon Files
|- js                 Site JS
|- json               Static JSON files
|- messages           Error Pages, Status Pages, etc.
|- md                 Static Markdown files
+- static             Static HTML, Legacy, or Page Assets that don't belong in the heirarchy
```

This layout can be replicated for daughter-sites or sister-sites, removing unneeded directories that won't be used, to avoid confusion. It's best to use the default host as a shared host (if the sites are related), and pulling in files using the `//default-host/path` syntax. As an alternative, you can create a separate "shared" host containing all of the assets used across the board. 

### Making a new site host: Start fresh, or copy?

#### Start fresh:

- If you have an already existing site and don't want duplicate content, pages, files all over the place. Keep in mind, when you copy a site, you're making duplicates of everything on that host, including non-working inodes. You can easily run into disk space issues by duplicating an already established host.

#### Copy:

- If you're making a new site based off of a new or mostly new site host
- If you want to have copies of everything for later modification
- If you're making a repository style shared host and want all assets to go with it. This is only recommended if the site doesn't have a lot of front-end content.

In most cases you will want to start with a fresh site.

---

## File Naming Examples

Velocity Files: `/application/widgets/news-trending.vtl`

Velocity Macros: `/application/macros/truncate-string.vm`

Velocity Includes: `/application/includes/social-meta.vtl`

Custom Fields: `/application/custom-fields/button.vtl`

---

## Using Legacy Containers

- It is best to use VTL files with a `#dotParse()` in the main section for each Content Type, so the Velocity remains consistent between different containers.

### Example

#### Pre-Loop

```
<!-- START: Container X -->
```

#### Main

```
#dotParse("/application/content-types/content-generic.vtl")

```

#### Post-Loop

```
<!-- END: Container X -->
```

#### Useful Tip

If you have it, use the `#ContainerInfo($CONTAINER_INODE)` macro and it will display useful information about the container in edit mode.

---

## Widget Instances

- _Avoid_ using the container's built-in Velocity variable generator
- _Do_ Use `$ContentIdentifier` in a `$dotcontent.find()` to get full access to the ContentMap Object as well as the underlying abstracted Classes.

### Example
```
#set ($myWidget = $dotcontent.find("$!{ContentIdentifier}"))

$myWidget.radioField.selectValue
$myWidget.imageField.uri
```

The reason for this is then this code becomes reusable directly in container code (hopefully a VTL file) as well as other variants of the Widget + code as the properties and methods available are always the same.

### Widgets that pull Contentlet Relationships

For each Contentlet that you pull in a widget and have listed. You can use `#editContentlet($myWidgetContentMapObject.inode)` to display an "Edit Content" button in Edit mode.


#### Useful Tip

If you have it, use the `#ContentletInfo($myWidgetContentMapObject)` macro and it will display useful information about the widget/content in edit mode.