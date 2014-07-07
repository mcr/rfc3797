#!/bin/sh

mkdir -p OUTPUT
rfc3797 <<EOF | tee OUTPUT/output-2012.txt | diff - output-2012.txt
134
12
17 20 22 35 38 48 36
90193202
55598744
11 17 21 48 50 9 10
end
EOF 

