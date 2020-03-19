# Velocity developer reference for dotCMS


## &nbsp;
# dotCMS ViewTools
- [dotCMS defined ViewTools (`toolbox.xml`)](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/webapp/WEB-INF/toolbox.xml)
- [OOB ViewTools Java Files](https://github.com/dotCMS/core/tree/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools)
---

## &nbsp;
# dotCMS contentMap Object
- **Class**: `com.dotcms.rendering.velocity.viewtools.content.ContentMap`
- **Reference Documents**: [Github](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/content/ContentMap.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/content/BinaryMap.html)

### Getting Content Type information from contentMap
```
$content.structure
```

---


## &nbsp;
## Content Type (Structure) Object `StructuresWebAPI`
- **Class**: `com.dotcms.rendering.velocity.viewtools.StructuresWebAPI`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/StructuresWebAPI.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/StructuresWebAPI.html)

#### Get list of structures
---


## &nbsp;
# dotCMS Field Objects

## &nbsp;
## Binary field
- **Class**: `com.dotcms.rendering.velocity.viewtools.content.BinaryMap`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/content/BinaryMap.java),  [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/content/BinaryMap.html)

### Image URI (Content Asset Path)
```
$content.binaryField.rawUri

Result: /contentAsset/raw-data/1234567890/binaryField
```

### Filter compatible image URI
```
/contentAsset/image/$content.identifier/binaryField/filter/{filterName}/{filterValue}
```

### Image URI (Content Asset Path)
```
$content.binaryField.rawUri

Result: /contentAsset/raw-data/1234567890/fieldBinary
```

### File name
```
$content.binaryField.name
```
---


## &nbsp;
## Category Field
- **Class**: `java.util.ArrayList` containing `com.dotmarketing.portlets.categories.model.Category`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotmarketing/portlets/categories/business/CategoryAPI.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotmarketing/portlets/categories/model/Category.html)

### Category Name
```
$categoryObject.name

Example:
#foreach ($category in $content.categoryField)
    $category.name
#end
```

### Category Velocity Variable Name
```
$categoryObject.categoryVelocityVarName

Example:
#foreach ($category in $content.categoryField)
    $category.categoryVelocityVarName
#end
```

### Category Key Value
```
$categoryObject.key

Example:
#foreach ($category in $content.categoryField)
    $category.key
#end
```
---


## &nbsp;
## Checkbox Field
- **Class**: `com.dotcms.rendering.velocity.viewtools.content.CheckboxMap`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/content/CheckboxMap.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/content/CheckboxMap.html)

### Get all possible options (Text)
```
$content.checkboxField.options

Result: ["Item 1", "Item 2"]
```

### Get all possible values 
```
$content.checkboxField.values

Result: ["item-1","item-2"]
```

### Get actual selected values
```
$content.checkboxField.selectedValues

Result: ["item-2"]
```

### Checking for null (no selections)
```
#if ($UtilMethods.isSet($content.checkboxField.selectedValues))
    has selections
#else
    no selections
#end
```

### Checking if specific value is selected
```
## Using contains()
#if ($content.checkboxField.selectedValues.contains("my-value"))
    has my-value
#else
    doesn't have my-value
#end

## Using indexOf()
#if ($content.checkboxField.selectedValues.indexOf("my-value") > -1)
    has my-value
#else
    doesn't have my-value
#end
```
---


## &nbsp;
## Date/Time Fields
- **Class**: `java.sql.Timestamp`
- **Ref for** `java.sql.Timestamp`: [JavaDoc](https://docs.oracle.com/javase/8/docs/api/java/sql/Timestamp.html)
- **Reference Documents**:
  - [JavaDoc DateTool (Apache)](https://velocity.apache.org/tools/2.0/apidocs/org/apache/velocity/tools/generic/DateTool.html)
  - [JavaDoc SimpleDateFormat (Oracle)](https://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html)
  - [dotCMS ViewTool Documentation](https://dotcms.com/docs/latest/date-viewtool)
  - [dotCMS Calendar, date comparison, and date math documentation](https://dotcms.com/docs/latest/adding-days-and-comparing-dates)

### Format Date field
```
$date.format("MM/dd/YYYY hh:mm:ss a", $content.dateField)
```

### Get UNIX Epoch Timestamp from field
```
$a.dateField.getTime()
```

### Get current UNIX Epoch Timestamp from system
```
$date.calendar.getTimeInMillis()
```

### Convert Epoch Timestamp into Date Object
```
#set ($myDate = $date.toDate(1475594610991))
```

### Convert Date Object Into Calendar
```
#set ($myCalendar = $date.toCalendar($content.dateField))

or convert string to date to pass into calendar

#set ($myCalendar = $date.toCalendar($date.toDate(1475594610991)))
```

### Manipulate dates with Date object converted to Calendar object
```
#set ($myCalendar = $date.toCalendar($a.dateField))


#set ($dummy = $myCalendar.add(1, 3))            ## Add 3 years

3 Years from Now: $date.format("MMMM, d YYYY", $myCalendar)

#set ($dummy = $myCalendar.add(5, -90))          ## Subtract 90 days

90 Days Less than 3 Years From Now: $date.format("MMMM, d YYYY", $myCalendar)
```
---


## &nbsp;
## File / Image Field
- **Class**: `com.dotcms.rendering.velocity.viewtools.content.FileAssetMap`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/content/FileAssetMap.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/content/FileAssetMap.html)

### Get file/image URI
```
$content.fileField.uri
```

### Get file/image "shorty" URL
```
$content.fileField.shortyUrl
```

### Get file/image Host identifier
```
$content.fileField.host
```

### Get file/image Host name
```
$content.fileField.hostName
```

### Get file name
```
$content.fileField.fileName
```

### Get file path
```
$content.fileField.path
```

### Get file size (in bytes)
```
$content.fileField.size
```

### Get disk path
```
$content.fileField.fileAsset.path
```

### Image Only: get metadata properties

> NOTE: Image field `metadata` property is a JSON formatted string, which can be converted into a useable JSON object
```
#set ($imageMetadata = $json.generate($a.imageField.metaData))

Result:
{"height":"1440","width":"2560","keywords":"stuff","contentType":"image/jpeg","fileSize":"201923"}
```

### Using Shorty URLs with image filters
> NOTE: Quality only works in JPEG images, which can be checked with the metadata object
```
Simple resizing and quality

## Resize to 400px (preserve ratio) width with 60% quality
$!{content.imageField.shortyUrl}/400w/60q

## Resize to 400px (preserve ratio) height with 60% quality
$!{content.imageField.shortyUrl}/400h/60q

## Resize to 640x400 (ratio not preserved)
$!{content.imageField.shortyUrl}/640w/400h

```

### Using advanced filters with contentAsset pathing
- [**Image Processing/filter chaining Reference**](https://dotcms.com/docs/latest/image-resizing-and-processing#quickReference)

> NOTE: File Asset identifier `identifier` or `inode`
> NOTE: Processed images are cached
```
## Grayscale
/contentAsset/image/$!{a.imageField.identifier}/fileAsset/filter/Grayscale

## Resize
/contentAsset/image/$!{a.imageField.identifier}/fileAsset/filter/Jpeg/jpeg_q/50

## Chaining multiple filters
/contentAsset/image/$!{a.imageField.identifier}/fileAsset/filter/Rotate,Jpeg/rotate_a/180.0jpeg_q/50
```
---


## &nbsp;
## Radio Field
- **Class**: `com.dotcms.rendering.velocity.viewtools.content.RadioMap`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/content/RadioMap.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/content/RadioMap.html)


### Get all possible options (Text)
```
$content.radioField.options

Result: ["Item 1", "Item 2"]
```

### Get all possible values 
```
$content.radioField.values

Result: ["item-1","item-2"]
```

### Get actual selected value
```
$content.radioField.selectValue

Result: ["item-2"]
```

### Checking for null (no selection)
```
#if ($UtilMethods.isSet($content.radioField.selectValue))
    has a selection
#else
    no selection (null)
#end
```

### Checking if specific value is selected
```
#if ($content.radioField.selectValue == "my-value")
    my-value is selected
#else
    my-value not selected
#end
```
---


## &nbsp;
## Relationship Field
- **Class**: `java.util.ArrayList` of `com.dotcms.rendering.velocity.viewtools.content.ContentMap`(s)
- **Reference Documents**: [Relationship Documentation](https://dotcms.com/docs/latest/pull-and-display-related-content)

### Getting related contentlets from content object
```
$content.relationshipField

## Loop through all related contentlets in field

#foreach ($con in $content.relationshipField)
    Do things
#end
```

### Getting related contentlets Using pullRelatedField(), allowing for parameters

##### No conditions
```
## Supply null or empty string
$dotcontent.pullRelatedField($content.identifier, "ContentType.relationshipField", $__null)
```

##### With condition (supply null for no conditions as field is required)
```
$dotcontent.pullRelatedField($content.identifier, "ContentType.relationshipField", "+ChildCT.title:HELLO")
```

##### Sort relationships
> NOTE: By default, order of related contentlets is dictated by the order in the field
```
$dotcontent.pullRelatedField($content.identifier, "ContentType.relationshipField", $__null, "modDate desc")
```

##### Limit number of results (sort field is required for some reason)
```
$dotcontent.pullRelatedField($content.identifier, "ContentType.relationshipField", $__null, 5, "modDate desc")
```
---


## &nbsp;
## Select Field
- **Class**: `com.dotcms.rendering.velocity.viewtools.content.SelectMap`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/content/SelectMap.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/content/SelectMap.html)

### Get all possible options (Text)
```
$content.selectField.options

Result: ["Item 1", "Item 2"]
```

### Get all possible values 
```
$content.selectField.values

Result: ["item-1","item-2"]
```

### Get actual selected value
```
$content.selectField.selectValue

Result: ["item-2"]
```

### Checking for null (no selection)
```
#if ($UtilMethods.isSet($content.selectField.selectValue))
    has a selection
#else
    no selection (null)
#end
```

### Checking if specific value is selected
```
#if ($content.selectField.selectValue == "item-2")
    item-2 is selected
#else
    item-2 not selected
#end
```
---

## &nbsp;
## Key/Value Field
- **Class**: Returns: `com.dotcms.rendering.velocity.viewtools.content.ContentMap$1` but is *really* a `java.util.HashMap`

### Iterating through key/value list
```
#foreach ($entry in $content.keyValueField.map.entrySet())
Key Name:  $entry.key
Key Value: $entry.value
#end
```
---


# Content paths

### ShortyPath

```
/da/$content.imageField.identifier
```

TODO

---


## &nbsp;
## &nbsp;
# Array Lists
- **class**: `java.util.ArrayList`
- **Reference Document**: [JavaDoc](https://docs.oracle.com/javase/8/docs/api/java/util/ArrayList.html)

#### Define Array List
```
#set ($myArr = [])

## or

#set ($myArr = $contents.getEmptyList())

Result: []
```

#### Define Array List with Values
```
#set ($myArr = [false, true, "one", 'two', 3 ])
```

#### Check if Array contains a value
```
$myArr.contains("one")  ## True/False
```

#### Check if Array contains a value or get index of value
```
$myArr.indexOf("one")  ## returns index integer, or -1 if value doesn't exist in Array
```

#### Get value of specific position
```
#set ($myArr = ["zero", "first", "second", "third, "fourth"])

$myArr[2]
## Result: second

$myArr.get(0)
## Result: zero
```

### Append/remove items to/from Array
> NOTE: While a two-handed approach isn't always necessary, it will ensure the code is always executed
```
#set ($myArr = ["zero", "first", "second", "third", "fourth"])

#set ($dummy = $myArr.add("fifth"))

$myArr[5]

## Result: fifth

#set ($dummy = $myArr.remove("fifth"))

$myArr

## Result: [zero, first, second, third, fourth]

#set ($dummy = $myArr.remove(2))

$myArr

## Result: [zero, first, third, fourth]

```
---
## &nbsp;
## &nbsp;


# Array Hash Maps

TODO

---


## &nbsp;
## &nbsp;


# Strings

TODO

---



## &nbsp;
## &nbsp;


# Integers and Math

TODO

---

## &nbsp;
## &nbsp;
## &nbsp;
# Other ViewTools


## &nbsp;
## VelocityRequestWrapper ($request)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## UrlRewriteWrappedResponse ($response)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## VelocitySessionWrapper ($session)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## CMSUsersWebAPI ($cmsuser)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## CookieTool ($cookietool)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## ConfigTool ($config)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## EscapeTool ($esc)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## UtilMethods ($UtilMethods)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## JSONTool ($json)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## ImportTool ($import)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## CategoriesWebAPI ($categories)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## ContentTool ($dotcontent)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---

## &nbsp;
## WorkflowTool ($workflowtool)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## ContentsWebAPI ($contents)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## FolderWebAPI ($folderAPI)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## SortTool ($sorter)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## DotLoggerTool ($dotlogger)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## MailerTool ($mailer)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## CalendarWebAPI ($calendar)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## LanguageViewtool ($text)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## MathTool ($math)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## NumberTool ($number)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## WebAPI ($webapi)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## NavTool ($navtool)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## ChainedContext ($context)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## FileTool ($filetool)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## CryptWebAPI ($crypt)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## DotRenderTool ($render)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## VelocityWebUtil ($velutil)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## WebsiteWebAPI ($website)
- **Class**: `CLAZZ`
- **Reference Documents**: [GitHub](), [JavaDoc]()

TODO

---


## &nbsp;
## &nbsp;
# Velocity Directives

### Parse VTL/VM script
```
#dotParse('/application/vtl/myfile.vtl')
```

### Generic Server Side Include (file type must be allowed)
```
#dotInclude('/application/vtl/myfile.vtl')
#include('/application/vtl/myfile.vtl')    ## I think this is deprecated
```

### Evaluate String
```
#evaluate('#set ($str = "my string")')
```

### foreach
```
#foreach($item in $arr)
    $foreach.index     ## Index of iteration
    $foreach.count     ## Foreach iteration count (from 1)
    $foreach.hasNext   ## true / false
#end
```
---


## &nbsp;
## &nbsp;
## &nbsp;
# Template and Theme

## &nbsp;
## `$dotTheme`
TODO

## &nbsp;
## `$dotThemeLayout`
TODO

## &nbsp;
## `$dotPageContent`
TODO

---


## &nbsp;
## &nbsp;
## &nbsp;
# URL Mapped Content
TODO

---


## &nbsp;
## &nbsp;
## &nbsp;
# Custom Fields
TODO

---

## &nbsp;
## &nbsp;
## &nbsp;
# Miscellaneous

## &nbsp;
## Using Markdown to Parse text field as markdown
- **Markdown ViewTool Class**: `com.dotcms.rendering.velocity.viewtools.MarkdownTool`
- **Markdown ViewTool Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/MarkdownTool.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/MarkdownTool.html)

> NOTE: &nbsp; `getRaw()` returns unparsed text
```
$markdown.parse($content.getRaw("textField"))
```
---

## &nbsp;
## Get Request URI
```
$VTLSERVLET_URI           ## Returns URI path of page as known from Virtual Heirarchy
$request.getRequestURI()  ## Returns URI as requested by HTTP header
```
---

## &nbsp;
## Macro as a function returning data to a variable
```
#macro (CoolThing $string)
	<h1>I am macro outputting $string</h1>
#end 
#set ($output = "#CoolThing(\"my string\")" ) ## Wrapping in single quotes will not parse
```
---

## &nbsp;
## Pad JSON with named object so it can be prased properly, as a HashMap
TODO

---

# Old stuff (need to rework)


## &nbsp;
## Basic Dynamic Navigation List
```
#set( $list = $navtool.getNav("/") ) 
#foreach($n in $list)
    #set($children = $n.children) 
    #if($children && $children.size() > 0)
    <li class="has-dropdown">
        <a href="#">${n.title} <b class="caret"></b></a>
        <ul class="dropdown">
            #foreach($ch in $children)
            <li #if ($ch.active) class="active" #end><a href='${ch.href}'>${ch.title}</a></li>
            #end
        </ul>
    </li>
    #else
    <li #if ($n.active) class="active" #end><a href='${n.href}'>${n.title}</a></li>
    #end 
#end
```
---


## &nbsp;
## Force dotCMS to clear page cache
Append `?dotcache=refresh` in query string of URL
---


## &nbsp;
## Get Content Type's Field information
Reference(s):
https://dotcms.com/docs/com/dotmarketing/portlets/structure/model/Structure.html
https://dotcms.com/docs/com/dotmarketing/viewtools/ContentsWebAPI.html
https://dotcms.com/docs/4.0.0/javadocs/com/dotmarketing/viewtools/content/ContentMap.html
```
## From Content Type directly 
## $contents is reserved object from: com.dotmarketing.viewtools.ContentsWebAPI
#foreach ($field in $contents.getStructureByInode("xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx").fields)
    $field.fieldName
#end

## From a content pull
#set($content = $dotcontent.pull("+contentType:ContentTypeName",10,"modDate desc"))
#foreach ($field in $content.get(0).getStructure().fields)
	$field.fieldName
#end
```

---

### Get all page context information
```
#foreach($key in $context.getKeys())
        Key: $key | Value: $context.get($key)
#end
```

---


---

### Pull in a file and eval velocity (does work with non VTL files)
```
$render.eval("#include($webapi.getAssetPath('/virtual/path/to/file'))")
```

---

### Pull in a file via contentlet attachment and eval
```
#dotParse("$filetool.getFile(${contentlet.fileAssetFieldName.identifier},true).getURI()")
```


---
