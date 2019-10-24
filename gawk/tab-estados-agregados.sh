#!/usr/bin/awk -f

BEGIN {
    FS = ";"
}

NR != 1 {
    estados[$4]++
}

END {
    for(i in estados)
        print i ":\t" estados[i]
}