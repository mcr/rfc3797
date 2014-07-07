#!/bin/sh

mkdir -p OUTPUT
rfc3797 <<EOF| tee OUTPUT/output-2013.txt | diff - output-2013.txt
154
12
7 8 11 17 19 25 46
08285182
60115701
2 3 18 26 32 33 42
end
EOF 

