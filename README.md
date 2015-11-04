# DotCMSVelocity
DotCMS and Velocity Scripts and Stuff

## Collection of Useful things to be used with DotCMS and Velocity

## crumbtrails.vtl

### Purpose
Dynamically generate Bradcrumbs regardless of whether the page is within the standard scope or a URL Mapped page.

### How to use:

####Step 1: Place crumbtrails.vtl in your /application/vtl or /application/themes/*themeName* folder.

####Step 2: Edit your template to include the script in the desired location of your advanced template. Script includes a nav tag.
```
#dotParse("${dotTheme.path}crumbtrails.vtl")
```

####Step 3: Customize script/markup to your needs.


## URL Page Asset File Browser for custom fields

## urlFileBrowser.vtl

### Purpose
For adding a Page Asset file-browser in content. Useful for clients to browse and adding SEO friendly links without having to code.

### How to use: 

####Step 1: Place *urlFileBrowser.vtl* script in your /application/vtl directory

####Step 2: Create a Custom Field in your Structure and add this code.
```
<script>
var _dotCMSPageAssetBrowserTargetField = String ('myField'); // <-- Update This String with custom field variable name!
</script>
#dotParse('/application/vtl/urlFileBrowser.vtl')
```

####Step 3: Edit value of *_dotCMSPageAssetBrowserTargetField* to the Variable/ID of your custom field.
Example:
```
var _dotCMSPageAssetBrowserTargetField = String ('linkPage');
```

####Step 4: You should have now have a custom field with a button to browse for a Page Asset.
