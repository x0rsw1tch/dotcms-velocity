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

### Getting Content Type field information
```
$content.structure.fields  ## Array List
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


## &nbsp;
#### Define Array List
```
#set ($myArr = [])

or

#set ($myArr = $contents.getEmptyList())

Result: []
```


## &nbsp;
#### Define Array List with Values
```
#set ($myArr = [false, true, "one", 'two', 3 ])
```

## &nbsp;
#### Check if Array contains a value
`contains(Object o)`
```
$myArr.contains("one")  ## True/False
```


## &nbsp;
#### Check if Array contains a value or get index of value
```
#set ($myArr = ["zero", "first", "second", "third", "fourth"])

$myArr.indexOf("second")

Result: 2

$myArr.indexOf("nope")

Result: -1
```


## &nbsp;
#### Get value of specific position
```
#set ($myArr = ["zero", "first", "second", "third, "fourth"])

$myArr[2]
Result: second

$myArr.get(0)
Result: zero
```


## &nbsp;
#### Get length of Array
- `size()`
```
#set ($myArr = ["zero", "first", "second", "third, "fourth"])

$myArr.size()

Result: 5
```


## &nbsp;
### Append/remove items to/from Array
> NOTE: While a two-handed approach isn't always necessary, it will ensure the code is always executed
```
#set ($myArr = ["zero", "first", "second", "third", "fourth"])

#set ($dummy = $myArr.add("fifth"))

$myArr[5]

Result: fifth

#set ($dummy = $myArr.remove("fifth"))

$myArr

Result: [zero, first, second, third, fourth]

#set ($dummy = $myArr.remove(2))

$myArr

Result: [zero, first, third, fourth]
```
---


## &nbsp;
## &nbsp;
# Array Hash Maps
**Classes**:
- Using `{}`: `java.util.LinkedHashMap`
- Using `$contents.getEmptyMap()`: `java.util.HashMap`
**Reference Documentation**:
- `java.util.LinkedHashMap`: [JavaDoc](https://docs.oracle.com/javase/8/docs/api/java/util/LinkedHashMap.html)
- `java.util.HashMap`: [JavaDoc](https://docs.oracle.com/javase/8/docs/api/java/util/HashMap.html)


## &nbsp;
### Create new empty map
```
#set ($myMap = {})

or 

#set ($myMap = $contents.getEmptyMap())
```


## &nbsp;
### Create new map with contents
```
#set ($myMap = {
	'Name': "Frank Lloyd Wright",
	'Occupation': "Architect",
	'birthplace': 'Richland Center, WI'
})
```


## &nbsp;
### Add or remove items to map
```
#set ($dummy = $myMap.put("prop", "value"))

#set ($dummy = $myMap.remove("prop"))
```
---


## &nbsp;
## &nbsp;
# Strings
- **Class**: `java.lang.String`
- **Reference Document**: [JavaDoc](https://docs.oracle.com/javase/8/docs/api/java/lang/String.html)


## &nbsp;
### New String
```
#set ($myString = "This $anotherString.")  ## Contents will be parsed by Velocity

or

#set ($myString = 'This $anotherString.')  ## Contents will not be parsed by Velocity
```


## &nbsp;
### Concatenate String
`concat(String str)`
```
## Starting with...
#set ($myString = "This is")

#set ($myString = "${myString} a complete sentence.")

or

#set ($myString = $myString + " a complete sentence.")

or

#set ($dummy = $myString.concat(" a complete sentence."))
```


## &nbsp;
### Get index position of string occurrence
`indexOf(String str, int fromIndex)`
```
#set ($myString = "This is a complete sentence.")

$myString.indexOf('complete')

Result: 10

$myString.indexOf('arse')

Result: -1
```

## &nbsp;
### Get length of string
```
#set ($myString = "This is a complete sentence.")

$myString.length()

Result: 28
```


## &nbsp;
### Find if string contains occurrence of string
```
#set ($myString = "This is a complete sentence.")

$myString.contains('complete')

Result: true

$myString.contains('arse')

Result: false
```


## &nbsp;
### Return a portion of string
`substring(int beginIndex)`
```
#set ($myString = "This is a complete sentence.")

$myString.substring(0, 15)

Result: This is a compl
```


## &nbsp;
### Replace something in a string
`replace(CharSequence target, CharSequence replacement)`
`replaceAll(String regex, String replacement)`
```
#set ($myString = "abcdefghijklmnop")
$myString.replace("cde", '')

Result: abfghijklmnop

#set ($myString = "/this crappy url.html")

$myString.replaceAll("\s", "-")

Result: /this-crappy-url.html
```


## &nbsp;
### Split String into `ArrayList`
```
#set ($myString = "abcdefg hijklmn op")

$myString.split(" ")

Result [abcdefg, hijklmn, op]
```
---


## &nbsp;
## &nbsp;
## &nbsp;
# ViewTools


## &nbsp;
## VelocityRequestWrapper ($request)
- **Class**: `com.dotcms.rendering.velocity.viewtools.VelocityRequestWrapper`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/VelocityRequestWrapper.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/VelocityRequestWrapper.html)

### Get/Set HTTP Header
```
$request.getHeader("Content-Type")

$request.setHeader("Location", "/404.html")
```

### Get Request Parameter (Works with GET, POST, and PUT. Not sure about others)
```
$request.getParameter("query")
```

### Get all HTTP Header names
```
#foreach ($header in $request.getHeaderNames())
     Name: $header
    Value: $request.getHeader($header)
#end
```

### Get Request Locale
```
$request.getLocale()

Result: en_US
```

### Get Request Method (GET, PUT, POST, PATCH, DELETE, OPTIONS)
```
$request.getMethod()
```

### Get Request URI or URL
```
$request.getRequestURI()
$request.getRequestURL()
```

### Get Request Scheme (http/https)
```
$request.getScheme()

Result: https
```

### Get Request Port
```
$request.getServerPort()

Result: 443
```

### Get/Set Attributes
```
$request.getAttribute('javax.servlet.forward.request_uri')

$request.setAttribute('javax.servlet.error.status_code', 404)

```

## &nbsp;
### dotCMS specific Attributes
```
javax.servlet.forward.request_uri
javax.servlet.forward.context_path
javax.servlet.forward.servlet_path
javax.servlet.forward.mapping
com.dotmarketing.LOCALE
com.dotmarketing.frontend.locale
com.dotcms.repackage.org.apache.struts.action.MODULE
com.dotcms.directive.renderparams
CLICKSTREAM_RECORDED
com.dotmarketing.htmlpage.language.current
DOT_RULES_FIRED_ALREADY
idInode
com.dotmarketing.session_host
CMS_FILTER_URLMAP_OVERRIDE
```
---


## &nbsp;
## HttpServletResponse ($response)
- **Class**: `javax.servlet.http.HttpServletResponseWrapper`
- **Reference Documents**: [GitHub](), [JavaDoc](https://javaee.github.io/javaee-spec/javadocs/javax/servlet/http/HttpServletResponseWrapper.html)

### Set HTTP Status
```
$response.setStatus(404)

or 

$response.sendError(500, "whoops!")
```

### Send Redirect (302)
```
$response.sendRedirect("/login/")
```

### Get, Set, Add Headers
```
$response.getHeader("Location")

$response.setHeader("Location", "/login/")

$response.addHeader("X-Forwarded-Proto", "https")
```
---

## &nbsp;
## VelocitySessionWrapper ($session)
- **Class**: `com.dotcms.rendering.velocity.viewtools.VelocitySessionWrapper`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/730f8880e1aaea871ce8612fbdf3ab2e04fcd74e/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/VelocitySessionWrapper.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/VelocitySessionWrapper.html)

## &nbsp;
### Get Session ID
```
$session.getId()
```

## &nbsp;
### Get/Set/Remove Session attribute
```
$session.getAttribute("com.dotmarketing.htmlpage.language")

$session.setAttribute("something", "neat")

$session.removeAttribute("something")
```

## &nbsp;
### Set front-end user
```
$session.setAttribute("cms.user", $cmsuser.getUserByUserId("userID"))
```

### End Session (logout)
```
$session.invalidate()
```

## &nbsp;
### dotCMS Session Attributes
```
com.dotmarketing.frontend.locale
com.dotmarketing.LOCALE
com.dotcms.visitor
browserSniffer
clickstream
com.dotmarketing.htmlpage.language
com.dotmarketing.session_host
```
---


## &nbsp;
## CMSUsersWebAPI ($cmsuser)
- **Class**: `com.dotcms.rendering.velocity.viewtools.CMSUsersWebAPI`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/CMSUsersWebAPI.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/CMSUsersWebAPI.html)

### **User Object**: `com.liferay.portal.model.User`
- **Reference Documents**:  [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/liferay/portal/model/AccountModel.html)

## &nbsp;
### Get users with parameters
```
## By ID
#set ($user = $cmsuser.getUserById("userID"))

## By Email
#set ($user = $cmsuser.getUserByEmail("userID"))

## By Session
#set ($user = $cmsuser.getLoggedInUser($request))

## Get user map
#set ($userData = $user.getUserProxy())
```

## &nbsp;
### Is user "admin"?
```
#set ($userIsAdmin = $cmsuser.isCMSAdmin($user)) ## True | False
```

## &nbsp;
### Does user have specific role
```
#set ($userHasRole = $user.isUserRole($user, "Role Name")) ## True | False
```
---


## &nbsp;
## CookieTool ($cookietool)
- **Class**: `org.apache.velocity.tools.view.tools.CookieTool`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/org/apache/velocity/tools/view/tools/CookieTool.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/org/apache/velocity/tools/view/tools/CookieTool.html)

## Add cookie
> NOTE: This will only set a cookie in the current URI path context. If you need a cookie on "/", then do it in HTTP headers
```
$cookietool.add("name", "value", "age") ## age is optional
```

## Get cookie by name
```
$cookietool.get("JSESSIONID")
```
---


## &nbsp;
## ConfigTool ($config)
- **Class**: `com.dotcms.rendering.velocity.viewtools.ConfigTool`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/ConfigTool.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/ConfigTool.html)

## &nbsp;
### Get configuration properties by Type
```
$config.getStringProperty("propertyname", "defaultvalue")
$config.getBooleanProperty("propertyname", false|true)
$config.getIntProperty("propertyname", 6)

Other gets: getFloatProperty, getLongProperty, getStringArrayProperty
```
---


## &nbsp;
## EscapeTool ($esc)
- **Class**: `org.apache.velocity.tools.generic.EscapeTool`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/org/apache/velocity/tools/generic/EscapeTool.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/org/apache/velocity/tools/generic/EscapeTool.html)

## &nbsp;
### Escape Characters
| Character | Invoke             |
|-----------|--------------------|
| $         | $esc.d             |
| $         | $esc.dollar        |
| #         | $esc.h             |
| #         | $esc.hash          |
| "         | $esc.q             |
| "         | $esc.quote         |
| '         | $esc.s             |
| '         | $esc.singleQuote   |
| \         | $esc.backslash     |
| !         | $esc.e             |
| !         | $esc.exclamation   |

## &nbsp;
### Escape Functions
- $esc.java()
- $esc.javascript()
- $esc.html()
- $esc.sql()
---


## &nbsp;
## UtilMethods ($UtilMethods)
- **Class**: `com.dotmarketing.util.UtilMethods`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotmarketing/util/UtilMethods.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotmarketing/util/UtilMethods.html)


## &nbsp;
### Pad String
`padToLength(String baseString, int finalLength, String padString)`
```
#set ($str = "abcdefghij")
$UtilMethods.padToLength($str, 40, "-")
Result: abcdefghij------------------------------
```


## &nbsp;
### isSet: Checks not null and is not empty for
```
#set ($emptyString = "")
$UtilMethods.isSet($emptyString)
Result: false

#set ($notEmptyString = "abc")
$UtilMethods.isSet($emptyString)
Result: true

#set ($emptyArray = [])
$UtilMethods.isSet($emptyArray)
Result: false

#set ($notEmptyArray = ["one", "two"])
$UtilMethods.isSet($notEmptyArray)
Result: true
```


## &nbsp;
### Title Case String
```
#set ($str = "Lorem ipsum dolor sit amet")
$UtilMethods.capitalize($str)

Result: Lorem Ipsum Dolor Sit Amet
```

## &nbsp;
### Pluralize String
`pluralize(long num, String word)`
```
#set ($str = "result")
$UtilMethods.pluralize(2, $str)

Result: results
```

## &nbsp;
### Friendly string truncate
`shortstring(String text, int maxNumberOfChars, boolean includeEllipsis)`
```
$UtilMethods.shortstring($str, 50, true)
```

## &nbsp;
### encode/decode URL
```
#set ($str = "http://www.google.com/")
$UtilMethods.encodeURL($str)
Result: http%3A%2F%2Fwww.google.com%2F

#set ($str = "http%3A%2F%2Fwww.google.com%2F")
$UtilMethods.decodeURL($str)
Result: http://www.google.com/
```

## &nbsp;
### Join Array
`join(String[] strArray, String separator, boolean empty)`
```
#set ($myArray = ["one", "two", "three", "four"])
$UtilMethods.join($myArray, " ") ## Will append seperator at end
Result: one two three four 
```
---


## &nbsp;
## JSONTool ($json)
- **Class**: `com.dotcms.rendering.velocity.viewtools.JSONTool`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/JSONTool.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/JSONTool.html)


## &nbsp;
### Fetch JSON using remote URL (uses GET)
```
#set ($myJson = $json.fetch("https://postman-echo.com/get?foo1=bar1&foo2=bar2", timeout, headers))

$myJson.args
Result: 
    {
        "foo1": "bar1",
        "foo2": "bar2"
    }
```

## &nbsp;
### Fetch JSON using remote URL (uses POST or PUT)
```
#set ($myMap = {
	'one': "one",
	'two': "two"
})

#set ($myJson = $json.post("https://postman-echo.com/post", 10, headers, $myMap)) ## Can use put() instead of post()

Result: {"args":{"one":"one","two":"two"},"headers":{"content-length":"0","x-forwarded-proto":"https","host":"postman-echo.com","x-forwarded-port":"443","accept-encoding":"gzip,deflate","user-agent":"Apache-HttpClient/4.5.2 (Java/1.8.0_222)"},"data":{},"form":{},"files":{},"json":null,"url":"https://postman-echo.com/post?one=one&two=two"}
```
---


## &nbsp;
## ImportTool ($import)
- **Class**: `org.apache.velocity.tools.view.tools.ImportTool`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/org/apache/velocity/tools/view/tools/ImportTool.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/org/apache/velocity/tools/view/tools/ImportTool.html)

## &nbsp;
### Get raw text from remote URL (GET only)
```
$import.read("https://www.google.com")
```

---


## &nbsp;
## CategoriesWebAPI ($categories)
- **Class**: `com.dotcms.rendering.velocity.viewtools.CategoriesWebAPI`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/CategoriesWebAPI.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/CategoriesWebAPI.html)

**Category Object**: `com.dotmarketing.portlets.categories.model.Category`
- **Reference**: [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotmarketing/portlets/categories/model/Category.html)

## &nbsp;
### Get a category by key name
```
#set ($myCategory = $categories.getCategoryByKey("CategoryKeyName"))
```

## &nbsp;
### Get Child Categories via Parent Category Object
```
#set ($myCategory = $categories.getCategoryByKey("CategoryKeyName"))

#set ($childCategories = $categories.getActiveChildrenCategories($myCategory))
```
---


## &nbsp;
## ContentTool ($dotcontent)
- **Class**: `com.dotcms.rendering.velocity.viewtools.content.ContentTool`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/content/ContentTool.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/content/ContentTool.html)

## &nbsp;
### Do a content pull, returns array of contentMap objects
`pull(String query, String limit, String sort)`
```
#set ($content = $dotcontent.pull("+contentType:webPageContent", 0, "webPageContent.title asc"))
```

## &nbsp;
### Find contentlet by id
`find(String inodeOrIdentifier)`
```
#set ($specificContentlet = $dotcontent.find("identifier"))
```

## &nbsp;
### find related contentlets (legacy/deprecated)
`pullRelated(String relationshipName, String contentletIdentifier, boolean pullParents, int limit, String sort)`
> NOTE: Legacy relationships will be removed from dotCMS at some point, use relationship fields instead. More information can be found in the Relationships field section.
```
## boolean pullParents set to true will pull parent contentlets from child side of relationship
#set $relatedContentlets = $dotcontent.pullRelated("ParentCT-ChildCT", "identifier", false, 0, "ChildCT.name asc")
```
---

## &nbsp;
## WorkflowTool ($workflowtool)
- **Class**: `com.dotcms.rendering.velocity.viewtools.WorkflowTool`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/WorkflowTool.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/WorkflowTool.html)

#### System workflow IDs
| Action     | ID         |
---------------------------
| publish    | b9d89c803d |
| unpublish  | 38efc763d7 |
| archive    | 4da13a425d |
| delete     | 777f1c6bc8 |

## &nbsp;
### Publish Contentlet
> NOTE: Adding identifier will publish against an exiting contentlet
> NOTE: Invoking fire() inside a conditional does work. Exceptions will results in a falsy result.
```
#set ($myContentletMap = {
	'stName': "MyContentType",
    'title': "Hello world",
    'description': "lorem ipsum",
    'body": "<p>content!</p>"
})
$workflowtool.fire($myContentletMap, "b9d89c803d")
```
---


## &nbsp;
## ContentsWebAPI ($contents)
- **Class**: `com.dotcms.rendering.velocity.viewtools.ContentsWebAPI`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/ContentsWebAPI.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/ContentsWebAPI.html)
---


## &nbsp;
## FolderWebAPI ($folderAPI)
- **Class**: `com.dotcms.rendering.velocity.viewtools.FolderWebAPI`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/FolderWebAPI.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/FolderWebAPI.html)

### **Folder Object Class**: `com.dotmarketing.portlets.folders.model.Folder`
- **Reference**: [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotmarketing/portlets/folders/model/Folder.html)

## &nbsp;
### Get current folder
```
#set ($folderOjbect = $folderAPI.findCurrentFolder($VTLSERVLET_URI, $host))
```

---


## &nbsp;
## SortTool ($sorter)
- **Class**: `org.apache.velocity.tools.generic.SortTool`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/org/apache/velocity/tools/generic/SortTool.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/org/apache/velocity/tools/generic/SortTool.html)

## &nbsp;
### Sort Array
```
$sorter.sort([5, 3, 7])
Result: [3, 5, 7]
```

### Sort List of Maps
```
$sorter.sort([ {"name": "zxy"}, {"name": "abc"} ], "name")
Result: [{name=abc}, {name=zxy}]

$sorter.sort([ {"name": "zxy"}, {"name": "abc"} ], "name:desc")
[{name=zxy}, {name=abc}]
```
---


## &nbsp;
## DotLoggerTool ($dotlogger)
- **Class**: `com.dotcms.rendering.velocity.viewtools.DotLoggerTool`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/DotLoggerTool.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/DotLoggerTool.html)

## &nbsp;
### Send something to log file
```
$dotlogger.info("Something happened!")

Other Logging methods: warn(), error(), debug()
```

---


## &nbsp;
## MailerTool ($mailer)
- **Class**: `com.dotcms.rendering.velocity.viewtools.MailerTool`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/MailerTool.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/MailerTool.html)

> NOTE: dotCMS is preconfigured to transmit to a localhost mailserver. If you have postfix installed with default configuration (allowing messages from localhost), no additional configuration is requires

`$mailer.sendEmail(String to, String from, String subject, String message, Boolean html)`


## &nbsp;
### Send plain text email

```
$mailer.sendEmail("johnny5@gmail.com", "admin@example.com", "This is a test", "Testing 1-2-3", false)
```

## &nbsp;
### Send HTML email

```
#set ($emailHTML = "<h1>HELLO WORLD!</h1>")

$mailer.sendEmail("johnny5@gmail.com", "admin@example.com", "This is a test", $emailHTML, true)

```


> Pro-tip: An easy programmer friendly is to compose your body markup is to use `#define`, then `.toString()` your object when invoking `$mailer.sendEmail()`

```
#define ($emailHTML)

<h1>Hello World</h1>
<p>This is a <strong>test</strong> message. Pretty neat, eh?</p>

#end

$mailer.sendEmail("johnny5@gmail.com", "admin@example.com", "This is a test", $emailHTML.toString(), true)

```


---


## &nbsp;
## CalendarWebAPI ($calendar)
- **Class**: `com.dotmarketing.portlets.calendar.viewtools.CalendarWebAPI`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotmarketing/portlets/calendar/viewtools/CalendarWebAPI.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotmarketing/portlets/calendar/viewtools/CalendarWebAPI.html)
- dotCMS Calendar Documentation: https://dotcms.com/docs/latest/pull-calendar-events-nbsp-nbsp-i-calendar-find-i

```
findEvents(String hostId, Date fromDate, Date toDate, String tag, String keyword, String categoryInode, String sortBy, int offset, int limit)
```

---


## &nbsp;
## LanguageViewtool ($text)
- **Class**: `com.dotcms.rendering.velocity.viewtools.LanguageViewtool`
- **Reference Documents**: [GitHub](), [JavaDoc]()

## &nbsp;
### Get glossary key based on session language
```
$text.get("buttons.confirm")
```

## &nbsp;
### Set front-end language ID

```
$text.setLanguage(2)
```
---


## &nbsp;
## MathTool ($math)
- **Class**: `org.apache.velocity.tools.generic.MathTool`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/org/apache/velocity/tools/generic/MathTool.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/org/apache/velocity/tools/generic/MathTool.html)
- **dotCMS Documentation**: https://dotcms.com/docs/latest/mathtool

## &nbsp;
### Basic artihmetic
```
$math.add(x, y)
$math.sub(x, y)
$math.mul(x, y)
$math.div(x, y)
$math.mod(x, y)
$math.pow(x, y)
$math.abs(x)
$math.max(x, y)
$math.min(x, y)
$math.ceil(x)
$math.floor(x)
$math.round(x)
$math.roundTo(x, y)
$math.getAverage(l)
$math.getTotal(l)
$math.getRandom()
$math.random(x, y)
$math.toDouble(x)
$math.toInteger(x)
```

---


## &nbsp;
## NumberTool ($number)
- **Class**: `org.apache.velocity.tools.generic.NumberTool`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/org/apache/velocity/tools/generic/NumberTool.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/org/apache/velocity/tools/generic/NumberTool.html)

## &nbsp;
### Format numbers
```
#set ($num = 12.34)

$number.format ('currency', $num)
Result: $12.34

$number.format('integer', $num)
Result: 12
```

## &nbsp;
### Convert to Number
```
$number.toNumber("12")
Result: 12
```
---


## &nbsp;
## WebAPI ($webapi)
- **Class**: `com.dotcms.rendering.velocity.viewtools.WebAPI`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/WebAPI.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/WebAPI.html)
---


## &nbsp;
## NavTool ($navtool)
- **Class**: `com.dotcms.rendering.velocity.viewtools.navigation.NavTool`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/navigation/NavTool.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/index.html?com/dotcms/rendering/velocity/viewtools/navigation/NavTool.html)
- **Navtool Documentation**: https://dotcms.com/docs/latest/navtool-viewtool
- **Nav item Result Class**: `com.dotmarketing.viewtools.navigation.NavResult` or `com.dotcms.rendering.velocity.viewtools.navigation.NavResultHydrated`
  - **Reference**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/navigation/NavResult.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/navigation/NavResult.html)

Returns a list of pages and file assets (based on parameters) that have "show on menu" enabled

> NOTE: Does not respect asset permissions unless set in configuration

- `$navtool.getNav()`
  - Gets current level navigation
- Get specific navigation
  - `getNav(Host host, String path)`
  - `getNav(int level)`
  - `getNav(String path)`
  - `getNav(String path, long languageId)`
---


## &nbsp;
## ChainedContext ($context)
- **Class**: `org.apache.velocity.tools.view.context.ChainedContext`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/org/apache/velocity/tools/view/context/ChainedContext.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/org/apache/velocity/tools/view/context/ChainedContext.html)
---


## &nbsp;
## FileTool ($filetool)
- **Class**: `com.dotcms.rendering.velocity.viewtools.FileTool`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/FileTool.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/FileTool.html)

## &nbsp;
### Get File Asset Object by identifier
`getFile(String identifier, boolean live, [long languageId])`
```
#set ($file = $filetool.getFile("identifier", true))
```

## &nbsp;
### Get File Asset URI
```
#set ($file = $filetool.getFile("identifier", true))

$filetool.getURI($file)
```
---


## &nbsp;
## CryptWebAPI ($crypt)
- **Class**: `com.dotcms.rendering.velocity.viewtools.CryptWebAPI`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/CryptWebAPI.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/CryptWebAPI.html)

## &nbsp;
### Encrypt or decrypt a string
```
$crypt.crypt("abc123")
Result: Z/FssgdeJ+YlY=

$crypt.decrypt("Z/FssgdeJ+YlY=")
Result: abc123
```

---


## &nbsp;
## DotRenderTool ($render)
- **Class**: `com.dotcms.rendering.velocity.viewtools.DotRenderTool`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/tree/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/DotRenderTool.html)
- **dotCMS Documentation**: https://dotcms.com/docs/latest/rendertool
---


## &nbsp;
## VelocityWebUtil ($velutil)
- **Class**: `com.dotcms.rendering.velocity.viewtools.VelocityWebUtil`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/VelocityWebUtil.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/VelocityWebUtil.html)
---


## &nbsp;
## WebsiteWebAPI ($website)
- **Class**: `com.dotcms.rendering.velocity.viewtools.WebsiteWebAPI`
- **Reference Documents**: [GitHub](https://github.com/dotCMS/core/blob/master/dotCMS/src/main/java/com/dotcms/rendering/velocity/viewtools/WebsiteWebAPI.java), [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotcms/rendering/velocity/viewtools/WebsiteWebAPI.html)
- **Folder object**: `com.dotmarketing.portlets.folders.model.Folder`
  - **Reference**: [JavaDoc](http://static.dotcms.com/docs/5.1.6/javadocs/com/dotmarketing/portlets/folders/model/Folder.html)

## &nbsp;
### Get Current Folder
Returns folder object
```
$website.getFolder("/path/to/folder", "hostID")
```

## &nbsp;
### Get Sub-folders
Returns list of subdirectory folder objects
```
$website.getSubFolders("/path/to/folder", "hostID")
```

---


## &nbsp;
## &nbsp;
# Velocity Directives


### Set Variable
```
#set ($myVar = "abc123")
```


### Set variable with define, allows for Velocity parsing and multiple lines
```
#define ($myVar)
put whatever in here
#end
```


### Parse VTL/VM script
```
#dotParse ('/application/vtl/myfile.vtl')
```


### Generic Server Side Include (file type must be allowed)
```
#dotInclude ('/application/vtl/myfile.vtl')
#include ('/application/vtl/myfile.vtl')    ## I think this is deprecated
```

### Evaluate String
```
#evaluate('#set ($str = "my string")')
```

## Conditionals
```
#if ($something == "abc")
  something is abc
#else ($something == "def")
  something is def
#else
  something is not abc or def
#end
```

## Macros
> NOTE: Macros are not functions, but you can fake it to some degree. See examples below
### Define Macro
```
#macro (myMacro $param)
I am outputting $param
#end
```

### Invoke Macro
```
#myMacro ("some text")
Result: I am outputting some text
```

### foreach()
```
#foreach ($item in $arr)
    $foreach.index     ## Index of iteration
    $foreach.count     ## Foreach iteration count (from 1)
    $foreach.hasNext   ## true / false
#end
```


### Stop execution of current script
```
#stop
```


### Break out of a loop
```
#break
```

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

or

#set ($output = $render.recurse($context, "#CoolThing(\"my string\")"))
```

## &nbsp;
## Determine is page is being viewed in back-end
Ueeful if page break back-end previews
```
#set ($IS_BACKEND = false)
#if ($UtilMethods.isSet($session.getAttribute('com.dotmarketing.PAGE_MODE_SESSION')))
	#set ($IS_BACKEND = true)
#end

or check for the following

$EDIT_MODE
$PREVIEW_MODE
$ADMIN_MODE
$LIVE_MODE
```

---

## &nbsp;
## Wrap JSON with named object so it can be parsed properly. Unnamed objects will not parse with `JsonTool`
```
#set ($rawText = $import.read("https://example.com/api/json"))
#set ($jsonObject = $json.generate("{ \"data\": { $rawText }"))
```
---

# Snippets and Old stuff (need to rework)


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


### Get all page context information
```
#foreach($key in $context.getKeys())
    Key: $key | Value: $context.get($key)
#end
```
---


### Pull in a file and eval velocity
```
$render.eval("#dotInclude($webapi.getAssetPath('/path/to/file'))")
```
---


### Pull in a file via contentlet attachment and eval
```
#dotParse("$filetool.getFile(${contentlet.fileAssetFieldName.identifier},true).getURI()")
```
---


### Dynamically named variables
```
$webapi.setVelocityVar("abc", 123)
$abc ## Output: 123
```

Or:

```
## Make sure to wrap this in a #set()
#set ($_ = $context.getVelocityContext().put("abc", 123))
$abc ## Output: 123
```
---
