#INCLUDE(CMakeForceCompiler)


# this one is important
SET(CMAKE_SYSTEM_NAME Windows)

#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)


SET(CMAKE_FIND_ROOT_PATH ./)

# specify the cross compiler
SET(CMAKE_C_COMPILER  x86_64-w64-mingw32-gcc)
SET(CMAKE_CXX_COMPILER x86_64-w64-mingw32-c++)
SET(CMAKE_RC_COMPILER x86_64-w64-mingw32-windres)





# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE NEVER)
