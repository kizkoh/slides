#!/bin/sh

set -eu

usage()
{
    echo "usage:"
    echo "  $0 [slide dir name]"
    echo ""
    echo "options:"
    echo "  --help, -h                                   Show help"
    exit 0
}

flag_parse()
{
    for i in $*
    do
	case $i in
	    --help|-h)
		usage
	esac
	shift
    done
}

[ $# = "0" ] && usage
flag_parse $*

NAME="$1"

set -x
mkdir -pv ${NAME}
cp -prv ./css ${NAME}/css
mkdir -pv ${NAME}/images
curl https://remarkjs.com/downloads/remark-latest.min.js -o ./${NAME}/remark.js
# Slide HTML template
cat <<EOF > ${NAME}/slide.html
<!DOCTYPE html>
<html>
  <head>
    <title>Title</title>
    <link href="css/common.css" rel="stylesheet" type="text/css" media="all">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <style type="text/css">
      @import url(http://fonts.googleapis.com/css?family=Yanone+Kaffeesatz);
      @import url(http://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic);
      @import url(http://fonts.googleapis.com/css?family=Ubuntu+Mono:400,700,400italic);
      body { font-family: 'Droid Serif'; }
      h1, h2, h3 {
        font-family: 'Yanone Kaffeesatz';
        font-weight: normal;
      }
      .remark-code, .remark-inline-code { font-family: 'Ubuntu Mono'; }
    </style>
  </head>
  <body>
    <!-- <script src="https://gnab.github.io/remark/downloads/remark-latest.min.js" type="text/javascript"> -->
    <script src="./remark.js" type="text/javascript">
    </script>
    <script type="text/javascript">
      var slideshow = remark.create({
          sourceUrl: 'slide.md'
      });
      <!-- var slideshow = remark.create(); -->
    </script>
  </body>
</html>
EOF
# Markdown file templates
cat <<EOF > ${NAME}/slide.md
class: center, middle
name: inverse
layout: true
class: center, middle
---
## たいとるたいとる
.center[[@kizkoh](https://twitter.com/kizkoh)]
.center[2016-00-00]
.center[[にほんどっか](https://connpass.com/)]
EOF
