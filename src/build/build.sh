#!/bin/bash

# modify this if needed
innodir=~/.wine/drive_c/users/michel/Local\ Settings/Application\ Data/Programs/Inno\ Setup\ 6

builddir=tmpDir
j21dir=june-21

ver=`cat VERSION`


vstziplin=vst_june-21-${ver}_linux.zip
allzipwin=standvst_june-21_${ver}-x64.zip
stnzipmac=stand_june-21_${ver}-mac.zip


# Build for Linux 
rm -f -R $builddir
mkdir $builddir
cd $builddir
pwd
cmake ../../plugins/junosyxloader/
make
cp ../../doc/*.png .
cp ../../doc/*.texi .
pdftex manual.texi
pdftex manual.texi
mv manual.pdf june-21-manual.pdf

cd ..

rm -f -R $j21dir
mkdir $j21dir
cp $builddir/libjsl.so $j21dir
cp $builddir/june-21-manual.pdf $j21dir

cat ../cabbage-module/june-21.csd | sed  "s/{VERSION}/$ver/g" > $j21dir/june-21.csd

cp -R ../cabbage-module/dat $j21dir
cp -R ../cabbage-module/imgs $j21dir
cp -R ../cabbage-module/presets $j21dir
cp -R ./runtime/linux/* $j21dir

zip -r $vstziplin ${j21dir}/*


# Build for Windows 
rm -f -R $builddir
mkdir $builddir
cd $builddir
cmake -DCMAKE_TOOLCHAIN_FILE=../../plugins/junosyxloader/cmake/toolchain-w64.cmake  -S ../../plugins/junosyxloader/
make
cp ../../doc/*.png .
cp ../../doc/*.texi .
pdftex manual.texi
pdftex manual.texi
mv manual.pdf june-21-manual.pdf
cd ..

rm -f -R $j21dir
mkdir $j21dir
cp $builddir/libjsl.dll $j21dir
cp $builddir/june-21-manual.pdf $j21dir

cat ../cabbage-module/june-21.csd | sed  "s/\.\/libjsl.so/libjsl.dll/g;s/{VERSION}/$ver/g" > $j21dir/june-21.csd

EOF
cp -R ../cabbage-module/dat $j21dir
cp -R ../cabbage-module/imgs $j21dir
cp -R ../cabbage-module/presets $j21dir
cp -R ./runtime/windows/* $j21dir

zip -r ${allzipwin} ${j21dir}/*

# windows setup
rm -f -R innosetup/x64/june-21
cp -R $j21dir innosetup/x64/
cat innosetup/june-21.iss | sed  "s/{VERSION}/$ver/g" > innosetup/june-21-TEMP.iss
cd innosetup
wine "${innodir}"/Compil32.exe  /cc june-21-TEMP.iss
cd ..
rm innosetup/june-21-TEMP.iss


# Standalone Mac
# WARNING : doesn't compile libjsl => cross compiling from linux to darwin too complicated!
rm -f -R $builddir
mkdir $builddir
rm -f -R $j21dir
mkdir $j21dir
cd $builddir
cp ../../doc/*.png .
cp ../../doc/*.texi .
pdftex manual.texi
pdftex manual.texi
mv manual.pdf june-21-manual.pdf
cd ..
cp $builddir/june-21-manual.pdf $j21dir
cp -R runtime/mac/june-21.app ${j21dir}

cat ../cabbage-module/june-21.csd | sed  "s/\.\/libjsl.so/libjsl.dylib/g;s/{VERSION}/$ver/g" > $j21dir/june-21.app/Contents/june-21.csd

cp -R ../cabbage-module/dat ${j21dir}/june-21.app/Contents/
cp -R ../cabbage-module/imgs $j21dir/june-21.app/Contents/
cp -R ../cabbage-module/presets $j21dir/june-21.app/Contents/

zip -r $stnzipmac ${j21dir}/*




# the end 
rm -f -R output
mkdir output
mv $allzipwin output/
mv $vstziplin  output/
mv $stnzipmac output/
mv innosetup/Output/*.exe output/
rm -f -R $builddir
rm -f -R $j21dir


