+++
title = "{{ getenv "HUGO_TITLE" }}"
date = {{ .Date }}
media = "Embroidery on Linen"
# exhibition = ""
# layout = 'page' # use this if it is a page with text on it
# draft = true
# description = 
# featured_image = 
# featured = true
# private = true
# sort_by = # name or date
# weight = # sort weight
# sort_order = # default is asc

{{- if getenv "HUGO_IMAGE_NAME" }}
src = "{{ getenv "HUGO_IMAGE_NAME" }}"
{{- end }}
{{- if getenv "HUGO_DIMENSIONS" }}
dimensions = "{{ getenv "HUGO_DIMENSIONS" }}"
{{- end }}
{{- if getenv "HUGO_SERIES" }}
{{- $seriesList := split (getenv "HUGO_SERIES") "|" }} 
series = [{{ range $index, $series := $seriesList }}{{ if $index }}, {{ end }}"{{ $series }}"{{ end }}]
{{- end }}
{{- if getenv "HUGO_EXHIBITED" }}
exhibited = "{{ getenv "HUGO_EXHIBITED" }}"
{{- end }}
{{- if getenv "HUGO_DATE_CREATED" }}
date_created = "{{ getenv "HUGO_DATE_CREATED" }}"
{{- end }}
{{- if getenv "HUGO_PRICE" }}
price = "{{ getenv "HUGO_PRICE" }}"
{{- end }}
{{- if getenv "HUGO_BUYER" }}
buyer = "REDACTED"
{{- end }}
{{- if getenv "HUGO_FROM_CSV" }}
from_csv = {{ getenv "HUGO_FROM_CSV" }}
{{- end }}
[[resources]]
  src = "{{ getenv "HUGO_IMAGE_NAME" }}"
  title = "{{ getenv "HUGO_TITLE" }}"
  [resources.params]
  date = ""

# these may come into play...
# OG Settings:
# anchor of the image crop 
#   The OG image is always cropped to 900x450 px
#   options: TopLeft, Top, TopRight, Left, Center, Right, BottomLeft, Bottom, BottomRight -- DEFAULTS TO Smart
# anchor: top
# scale of the image resize 
#   options: 'wide' (1500px),'medium' (1200px),'tight' (900px), 'none' -- DEFAULTS TO 'tight'
# scale: wide 
+++