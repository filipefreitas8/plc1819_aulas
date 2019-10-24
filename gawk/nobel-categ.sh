#!/usr/bin/awk -f

BEGIN {
    FS = ";"
}

NR != 1 {
    categorias[$2]++
}

END {
    for(i in categorias)
        print i ": " categorias[i]
}
