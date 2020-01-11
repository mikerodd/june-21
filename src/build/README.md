# Building June-21 packages (Linux only) 

If you want to build june-21 distribution yourself, you can use this script.
Some minor modification sould be done on directories 

These are the dependencies : 
- in order to compile libjsl: 
  - gcc (any recent version should do)
  - a Windows cross-compilation toolchain (for instance mingw-w64 on Ubuntu) 
  - CMake 
- to create Windows setup file : [innosetup](https://www.jrsoftware.org/isinfo.php) 
- In order to create the manual : tex/latex tools (texlive and texlive-latex-extra on Ubuntu) 
