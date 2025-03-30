+++
title = "{{ getenv "HUGO_TITLE" }}"
date = {{ .Date }}
media = "Embroidery on Linen"
# layout = 'page' # use this if it is a page with text on it
# draft = true
# description = 
# featured_image = 
# featured = true
# private = true
# src = ""
# dimensions = ""
# series = ["The Collection"]
# exhibitions = []
# exhibited = "|"
# date_created = ""
# price = ""
# [[resources]]
#   src = ""
#   title = ""
#   [resources.params]
#   date = ""

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
{{- $seriesList := split (getenv "HUGO_EXHIBITED") "|" }}
{{- $hasNo := false }}
{{- range $seriesList }}
{{- if eq (lower .) "no" }}
{{- $hasNo = true }}
{{- end }}
{{- end }}
{{- if not $hasNo }}
exhibitions = [{{ range $index, $series := $seriesList }}{{ if $index }}, {{ end }}"{{ $series }}"{{ end }}]
{{- end }}
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
{{- if getenv "HUGO_IMAGE_NAME" }}
[[resources]]
  src = "{{ getenv "HUGO_IMAGE_NAME" }}"
  title = "{{ getenv "HUGO_TITLE" }}"
  [resources.params]
  date = ""
{{- end }}
+++