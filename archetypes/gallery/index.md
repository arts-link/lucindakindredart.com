---
title: '{{ (.File.ContentBaseName | dateFormat "January 2, 2006") }}'
media: ['Embroidery on Linen']
# topics: []
date: {{ (.File.ContentBaseName | dateFormat "2006-01-02") }}
# OG Settings:
# anchor of the image crop 
#   The OG image is always cropped to 900x450 px
#   options: TopLeft, Top, TopRight, Left, Center, Right, BottomLeft, Bottom, BottomRight -- DEFAULTS TO Smart
# anchor: top
# scale of the image resize 
#   options: 'wide' (1500px),'medium' (1200px),'tight' (900px), 'none' -- DEFAULTS TO 'tight'
# scale: wide 
---
