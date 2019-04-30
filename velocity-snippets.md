# Velocity Snippets

### Output path to content image URL
```
${item.imageVar.uri}
${item.imageVar.rawUri}      ## Binary
${largeImageBinaryFileURI}
```

---

### Parse through a script
```
#dotParse('/application/vtl/myfile.vtl')
```

---

### Common Classes

```
com.dotmarketing.beans.Host                             $host
com.dotmarketing.viewtools.content.ContentTool          $dotcontent
com.dotcms.rendering.velocity.viewtools.ContentsWebAPI  $contents
com.dotmarketing.viewtools.WebAPI                       $webapi
com.dotmarketing.viewtools.VelocityWebUtil              $velutil
com.dotmarketing.util.InodeUtils                        $InodeUtils
com.dotcms.rendering.velocity.viewtools.WorkflowTool    $workflowtool
```


---

### Array of Arrays
```
#set( $tmp = [] )
## Using the method to set dummy ensures the line gets parsed and $tmp array is pushed
#set( $dummy = $tmp.add( {  "item1" : "Test Property 1", "item2" : "Test Property 2" } ) )
```

---

### Split URL into folder list
```
#set($folder = $URLMapContent.URL_MAP_FOR_CONTENT.split("/"))
```

---

### Get iNode from URL Map
```
## For checking if there is a URLMap specified 
## Parameter in URL to specify a specific piece of content
## ie: http://www.mysite.com/blog/a-cool-article-thing
## Useful for displaying list/detail views on the same page
### DETAIL PAGE
#if($URLMapContent.inode)										## Check for URLMap
	#set ( $item = $dotcontent.find($URLMapContent.inode) )		## Lookup iNode
	## Do the things
#else
  ## Display nothing and show listing instead.
#end
```

---

### foreach loop and specifics
```
#foreach($item in $var)
	## Stuff
	#if ($foreach.index > 0)
		###How far into loop are we? ########
		## Do the things
	#end
	
	if ($foreach.hasNext)
		###If there another item after this one? ########
		## Do the things
	#end

	## How many iterations have I gone thru?
	$foreach.count
#end
```
---

### Get navigation path array (Doesn't work for URLMapped Paths )
```
#set($navi = $navtool.nav)
## Structure
$navi.title
$navi.href
```

---

### Get current folder
```
#set ($folder = $VTLSERVLET_URI)
```

---

### Find out if a thing contains x
```
#if ($thing.contains('foo'))
	## Do the things
#end
```

---

### Replace Occurrences in a string
```
$item.replaceAll("occurrence", "newthing")
$myString.replace('-',' ')
```

---

### Check length of thing
```
#if($thing.length() > 0)
	## Do the things
#end
```

---

### Date/Time Formatting
```
$date.format('yyyy-MM-dd',$sysPublishDate)T$date.format('hh:mm:ss',$sysPublishDate)
$date.format('MMM dd yyyy', $item.sysPublishDate)
$date.format('HH:mm z', $item.sysPublishDate)
```

---

#### LIST PAGE
```
#if(!$URLMapContent)
#foreach($item in $dotcontent.pull("+contentType:StructureName +(conhost:SITE-Identifier conhost:SYSTEM_HOST)",10,"modDate desc"))
  ## Do the things
#end
```

---

### dotCMS Theme Path
```
$dotTheme.path
```

---

### String Concatination
```
#set ($myString = "$myString is awesome!")
```

---

### String to Lower Case
```
$myString.toLowerCase()
```

---

### String Substring-ing
```
$myString.substring(0,5)
```

---

### Macro as a function returning data to a variable
```
#macro (CoolThing)
	<h1>I am a macro</h1>
#end 
#set ($output = "#CoolThing()" )
```

---

### Macro as a function with Parameters
```
#macro (CoolThing $myThing)
	<h1>I am a macro with $myThing</h1>
#end 

#set ($thingString = "foo")
#set ($output = "#CoolThing($thingString)" )
## Outputs: <h1>I am a macro with foo</h1>
```

---

### Is something false?
```
#if(!$myVar) 
	\$MyVar is false
#end
```

---

### Get JSON from a URL (Pads "data" due to dotCMS JSON parsing bug - needs named object)
```
#set ($myHost = "https://webservices-webdev18.worldatwork.org/")
#set ($myPath = "customers/22222/")
#if($myHost && $myPath)
	## Read raw text in from URI - Append Data Object to work around dotCMS JSON 
	## tool bug (cant read in "unnamed" objects). This also may restrict or even 
	## remove our ability to utilize JSONtool filtering.
	#set($jrIn   = $import.read("$myHost$myPath"))
	#set($jrRaw  = "{data:${jrIn}}")
	#set($myJSON = $json.generate($jrRaw))
#end
```

---

### Get contentlet related contentlets
```
## false = child relation
## true = parent relation
#foreach($rcon in $dotcontent.pullRelated("StructureName","BaseContentlet.identifier",false,10))
  ## Do the things
#end
```

---

### Basic Dynamic Navigation List
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

### Force dotCMS to clear page cache
```
$response.sendRedirect('/?dotcache=refresh')
```

---

### dotCMS simulate user logging in via native user API (jQuery)
```
<script type="text/javascript">
    var formData = {
        _loginAction: 'login',
        _loginUserName: 'bill@dotcms.com',
        _loginPassword: 'bill',
        _loginButton: null
    };
    
    $.ajax({
        url : "/login/authenticate",
        type: "POST",
        data : formData,
        success: function(data, textStatus, jqXHR)
        {
            //data - response from server
        },
        error: function (jqXHR, textStatus, errorThrown)
        {

        }
    });
</script>
```

---

### UNIX Timestamp
```
$date.calendar.getTimeInMillis()
```

### Time in Milliseconds
```
Day:       86400000
5 Days:    432000000
1 Week:    604800000
2 Weeks:   1209600000
30 Days:   2592000000
31 Days:   2678400000
90 Days:   7776000000
6 Months:  15552000000
9 Months:  23328000000
1 Year:    31536000000
2 Years:   63072000000
```


---

### Date Formatting
```
#set ($dateFormat = 'MMMM d, yyyy') ## October 4, 2016
#set ($dateFormat = 'MMMM dd, yyyy') ## October 04, 2016
#set ($dateFormat = 'MMM d, yyyy') ## Oct 04, 2016
#set ($dateFormat = 'MM-dd-yyyy') ## 10-04-2016
#set ($dateFormat = 'MM/dd/yyyy') ## 10/04/2016

$date.format($dateFormat, $date.calendar.getTimeInMillis())
```


---

### Convert Timestamp into Date Object
```
#set ($myDate = $date.toDate(1475594610991))
```

### Convert Date Object Into Calendar
```
#set ($myDate = $date.toDate(1475594610991))
#set ($myCalendar = $date.toCalendar($myDate))
```

---

### Manipulate Calendar Date
[dotCMS Article](https://dotcms.com/docs/latest/adding-days-and-comparing-dates)
```
#set ($myCalendar = $date.toCalendar($date.toDate(1475594610991)))
Now: $date.format("MMMM, d YYYY", $myCalendar)

#set ($dummy = $myCalendar.add(1,3)) ## Add 3 years
3 Years from Now: $date.format("MMMM, d YYYY", $myCalendar)

#set ($dummy = $myCalendar.add(5,-90)) ## Subtract 90 days
90 Days Less than 3 Years From Now: $date.format("MMMM, d YYYY", $myCalendar)
```

---

### Get key/pair field names and values
```
#foreach($key in $content.fieldName.map.keySet())
	Name: $key
	Value: $content.fieldName.map["$key"]
#end
```

---

### Get Content Type's Field information
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

### Pull in a file
```
#include($webapi.getAssetPath('/virtual/path/to/file'))
```

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

### Custom Field, pull in jQuery
```
<script>

if (typeof jQuery != 'undefined') {

} else {
	(function(e,s){e.src=s;e.onload=function(){jQuery.noConflict();console.log('jQuery injected')};document.head.appendChild(e);})(document.createElement('script'),'/js/jquery.min.js')
}
</script>
```