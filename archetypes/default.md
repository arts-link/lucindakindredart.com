+++
title = '{{ getenv "HUGO_TITLE" }}'
date = {{ .Date }}
media = 'Embroidery on Linen'
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
series = ['cool']
dimensions = "{{ getenv "HUGO_DIMENSIONS" }}"
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
