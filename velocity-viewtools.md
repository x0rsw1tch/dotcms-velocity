# dotCMS Velocity Viewtools


## FolderWebAPI

### Class
```com.dotcms.rendering.velocity.viewtools.FolderWebAPI```

### Viewtool
```$folderAPI```

### Code
[GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/FolderWebAPI.java)

### Examples

#### Get Current Folder

```
 $folderAPI.findCurrentFolder("/path/to/directory", $host)
```

Output: 
```
com.dotmarketing.portlets.folders.model.Folder
```

#### Get Folder Navigation Items