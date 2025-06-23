#!/bin/bash

set -e -u

OSTYPE=$(uname -s)
ARCH=$(uname -m)

patchedbB=/Users/fredsa/Documents/chunkypixel.atari-dev-studio-0.10.8-patched/out/bin/compilers/bB


make

echo $( basename $0 )

echo "Copying files:"
echo "  src: $( pwd )"
echo "  dst: $patchedbB"
files=""
for i in $( find . -d 1 -type f -perm -u+x | grep -v makefile | grep -v $( basename $0 ) | xargs -n1 basename | xargs ls -1 )
do
    if [ -f "$patchedbB/$i.$OSTYPE.$ARCH" ]
    then
        cp "$i" "$patchedbB/$i.$OSTYPE.$ARCH"
        files="$files $i.$OSTYPE.$ARCH"
    fi
done

echo "$patchedbB/2600basic.sh"
if [ -f "$patchedbB/2600basic.sh" ]
then
    files="$files 2600basic.sh"
    cp 2600basic.sh $patchedbB/2600basic.sh
    sed -i -e 's/\( | bbfilter$EXT\)/ #\1/' $patchedbB/2600basic.sh
    echo
    echo "Patched: 2600basic.sh"
    diff 2600basic.sh $patchedbB/2600basic.sh || true
fi

echo
echo "Updated files:"
(cd $patchedbB; ls -l $files)
