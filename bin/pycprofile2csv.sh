#!/bin/bash 

awk '
BEGIN 
    {print "ncalls,tottime,percall,cumtime,percall,filename_lineno_function"} 
NR > 1 {
    if (NF < 6) next;  # Skip rows with fewer than 6 fields
    # Process the first 5 fields
    for (i = 1; i <= 5; i++) {
        printf "%s%s", (i > 1 ? "," : ""), $i;
    }
    # Print the rest of the fields as they are
    printf ","
    for (i = 6; i <= NF; i++) {
        printf "%s%s", $i, (i < NF ? " " : "\n");
    }
}' $1 