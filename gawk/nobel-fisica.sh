#!/usr/bin/awk -f

BEGIN {
    FS = ";"
}

$2 == "physics" {
    print "Ano: " $1
    
    print "\t" $5 " " $6
    if ($10 != "")
        print "\t" $10 " " $11
    if ($15 != "")
        print "\t" $15 " " $16
    print "-----------------------------------------------------"
}

END { }
