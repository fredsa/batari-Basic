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
(cd $patchedbB; ls -l $files)
exit

# export bB=/Users/fredsa/.vscode/extensions/chunkypixel.atari-dev-studio-0.10.8/out/bin/compilers/bB/
# export bB=/Users/fredsa/Documents/chunkypixel.atari-dev-studio-0.10.8-patched/out/bin/compilers/bB/

2600basic
2600basic.sh
bbfilter
install_ux.sh
makefile
makefile.linux-x64
makefile.linux-x86
makefile.xcmp.osx-x64
makefile.xcmp.osx-x86
makefile.xcmp.win-x64
makefile.xcmp.win-x86
makepackages.sh
optimize
postprocess
preprocess