# Content Types

# Index

1. [Content Widget](#content-widget)
1. [Structured Content Extended Meta-data](#structured-content-extended-meta-data)
1. [Template Parameters](#template-parameters)
1. [Page Asset Layout Field](#page-asset-layout-field)



<a name="content-widget"></a>

## Content Widget

### Description

Improved Version of VTL Include &amp; Content (Generic). Allows for including a file to be parsed and a WYSIWYG field.

### Installation

1. Edit `/content-types/content-widget.json`: Change Host Identifier in JSON file
1. Import Content Type using dotTools plugin with JSON file or manually through REST API
1. Upload `/includes/velocity-include.vtl` to `/application/containers`
1. Add the following code to the `Widget Code` Field:

```
#dotParse('/application/containers/velocity-include')
```

> If creating manually through REST API, each object in the list must be sent individually. dotCMS does not recognize the object structure in the JSON file.

### Usage

1. Create a `Content Widget` instance
1. Add a Velocity File to parse and/or add your code to the `code` field.


### Compatibility

| dotCMS 3            | dotCMS 4           | dotCMS 5
|---------------------|--------------------|-----------------
| :heavy_check_mark:  | :heavy_check_mark: | :heavy_check_mark:

---


<a name="structured-content-extended-meta-data"></a>

## Structured Content Extended Metadata

### Description

Provides an easy way to generate SEO meta-data for pages based on Content Type and URL Mapped Content Types.


### Installation

1. Edit `/content-types/structured-content-extended-metadata.json`: Change Host Identifier in JSON file
1. Import Content Type using dotTools plugin with JSON file or manually through REST API
1. Upload `/includes/social-meta.vtl` to `/application/includes`

> If creating manually through REST API, each object in the list must be sent individually. dotCMS does not recognize the object structure in the JSON file.

### Usage

1. Refer to Readme in [dotcms-starters](https://github.com/x0rsw1tch/dotcms-starters#structured-content-extended-meta-data)


### Compatibility

| dotCMS 3            | dotCMS 4           | dotCMS 5
|---------------------|--------------------|-----------------
| :heavy_check_mark:  | :heavy_check_mark: | :heavy_check_mark:

---

<a name="template-parameters"></a>

## Template Parameters

### Description

Allows for using custom row and column wrappers in dotCMS Basic Templates, instead of hard-coding markup wrappers in theme files. Layouts have a default Layout as a fallback. The layout field is a custom field as a drop-down selector located in the Page Asset Content Type.

### Installation

1. Edit `/content-types/template-parameters.json`. Change Host Identifier in JSON file
1. Import Content Type using dotTools plugin with JSON file or manually through REST API
1. Upload `/includes/template-parameters.vtl` to `/application/includes/template-parameters.vtl`
1. Upload `/macros/template-column.vm` to `/application/macros`
1. Upload the theme files `(/application/themes/default)` in the `dotcms-minimal-md.7z` to `/application/themes/theme-name`
1. Upload `/custom-fields/template-layout.vtl` to `/application/custom-fields`
1. Create a Custom Field in your Page Asset type called layout, add the following code in the field value:

```
#dotParse('/application/custom-fields/template-layout.vtl')
```

> If creating manually through REST API, each object in the list must be sent individually. dotCMS does not recognize this object structure.

### Usage

1. Refer to Readme in [dotcms-starters](https://github.com/x0rsw1tch/dotcms-starters#template-parameters)


### Compatibility

| dotCMS 3            | dotCMS 4           | dotCMS 5
|---------------------|--------------------|-----------------
| :heavy_check_mark:  | :heavy_check_mark: | :heavy_check_mark:

---

<a name="page-asset-layout-field"></a>

# Page Asset Layout Field

```
{
	"clazz": "com.dotcms.contenttype.model.field.ImmutableCustomField",
	"contentTypeId": "htmlpageasset",
	"dataType": "LONG_TEXT",
	"name": "Layout",
	"sortOrder": 7,
	"readOnly": false,
	"fixed": false,
	"required": false,
	"searchable": false,
	"indexed": false,
	"listed": false,
	"unique": false,
	"variable": "layout"
}
```

### Field Value

```
#dotParse('/application/custom-fields/template-layout.vtl')
```

---
