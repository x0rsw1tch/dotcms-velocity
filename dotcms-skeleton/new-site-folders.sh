export DOT_SITE="www.domain.com"
export DAV_SITE="www.domain.com"
export DOT_JWT="JSONWEBTOKEN"

curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/application
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/application/apivtl
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/application/async
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/application/containers
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/application/content-types
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/application/custom-fields
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/application/includes
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/application/macros
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/application/template-custom
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/application/themes
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/application/themes/default
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/application/util
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/application/util/css
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/application/util/js
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/application/util/reports
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/application/util/vtl
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/application/widgets
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/css
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/documents
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/downloads
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/img
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/js
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/json
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/media
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/message
curl -H "Authorization: Bearer ${DOT_JWT}" -X MKCOL https://${DOT_SITE}/webdav/live/1/${DAV_SITE}/static