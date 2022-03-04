#!/bin/bash
echo "#nk Total Energy" > kpts.log
list="4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50"
nkpt_old=2
for nkpt in $list
do
    sed -i -e 's/nk = '"$nkpt_old"'/nk = '"$nkpt"'/g' inp
    /Users/ftroisi/Desktop/Thesis/Octopus.nosync/Octopus/octopus/local_build/bin/octopus >& out-$nkpt
    energy="$(grep 'Total' static/info | head -2 | tail -1 | cut -d "=" -f 2)"
    echo $nkpt $energy >> kpts.log
    nkpt_old=$nkpt
    rm -rf restart
done