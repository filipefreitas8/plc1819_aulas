#!/usr/bin/awk -f

BEGIN { FS="::" }

{ print "<li>" $3 "</li>" > $1 ".html" }

