#!/bin/bash 


usage() {
    cat << EOF
This scripts convert cyrilic serbian letters to latinic serbian letters from stdin to stdout.

EOF
}

if [ $# -ne 0 ]; then
    usage
    exit 1
fi




# set locale to utf8
export LC_ALL=en_US.UTF-8
# stdin is utf8 encoded 

cat /dev/stdin  | \
    awk "
    BEGIN {
        cyr2lat[\"а\"]=\"a\"
        cyr2lat[\"б\"]=\"b\"
        cyr2lat[\"ц\"]=\"c\"
        cyr2lat[\"д\"]=\"d\"
        cyr2lat[\"е\"]=\"e\"
        cyr2lat[\"ф\"]=\"f\"
        cyr2lat[\"г\"]=\"g\"
        cyr2lat[\"х\"]=\"h\"
        cyr2lat[\"и\"]=\"i\"
        cyr2lat[\"ј\"]=\"j\"
        cyr2lat[\"к\"]=\"k\"
        cyr2lat[\"л\"]=\"l\"
        cyr2lat[\"м\"]=\"m\"
        cyr2lat[\"н\"]=\"n\"
        cyr2lat[\"о\"]=\"o\"
        cyr2lat[\"п\"]=\"p\"
        cyr2lat[\"р\"]=\"r\"
        cyr2lat[\"с\"]=\"s\"
        cyr2lat[\"т\"]=\"t\"
        cyr2lat[\"у\"]=\"u\"
        cyr2lat[\"в\"]=\"v\"
        cyr2lat[\"з\"]=\"z\"
        cyr2lat[\"љ\"]=\"lj\"
        cyr2lat[\"њ\"]=\"nj\"
        cyr2lat[\"ш\"]=\"sh\"
        cyr2lat[\"ђ\"]=\"dj\"
        cyr2lat[\"ч\"]=\"ch\"
        cyr2lat[\"ћ\"]=\"c\"
        cyr2lat[\"ж\"]=\"z\"
        cyr2lat[\"џ\"]=\"dz\"
        cyr2lat[\"А\"]=\"A\"
        cyr2lat[\"Б\"]=\"B\"
        cyr2lat[\"Ц\"]=\"C\"
        cyr2lat[\"Д\"]=\"D\"
        cyr2lat[\"Е\"]=\"E\"
        cyr2lat[\"Ф\"]=\"F\"
        cyr2lat[\"Г\"]=\"G\"
        cyr2lat[\"Х\"]=\"H\"
        cyr2lat[\"И\"]=\"I\"
        cyr2lat[\"Ј\"]=\"J\"
        cyr2lat[\"К\"]=\"K\"
        cyr2lat[\"Л\"]=\"L\"
        cyr2lat[\"М\"]=\"M\"
        cyr2lat[\"Н\"]=\"N\"
        cyr2lat[\"О\"]=\"O\"
        cyr2lat[\"П\"]=\"P\"
        cyr2lat[\"Р\"]=\"R\"
        cyr2lat[\"С\"]=\"S\"
        cyr2lat[\"Т\"]=\"T\"
        cyr2lat[\"У\"]=\"U\"
        cyr2lat[\"В\"]=\"V\"
        cyr2lat[\"З\"]=\"Z\"
        cyr2lat[\"Љ\"]=\"Lj\"
        cyr2lat[\"Њ\"]=\"Nj\"
        cyr2lat[\"Ш\"]=\"Sh\"
        cyr2lat[\"Ђ\"]=\"Dj\"
        cyr2lat[\"Ч\"]=\"Ch\"
        cyr2lat[\"Ћ\"]=\"C\"
        cyr2lat[\"Ж\"]=\"Z\"
        cyr2lat[\"Џ\"]=\"Dz\"
    } {
        for (i=1; i<=length(\$0); i++) {
            c = substr(\$0, i, 1)
            if (c in cyr2lat) {
                printf cyr2lat[c]
            } else {
                printf c
            }
        }
        printf \"\n\"
    }
    "

exit 0