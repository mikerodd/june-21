cmake_minimum_required(VERSION 2.8.12)

# Release or Debug
set(CMAKE_BUILD_TYPE "Release")

# switch RPATH use off
set(CMAKE_MACOSX_RPATH 0)
# force make to print the command lines
set(CMAKE_VERBOSE_MAKEFILE on)
# path to Csound cmake module
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH}
"${CMAKE_SOURCE_DIR}/cmake/Modules/")
# set C++ compilation flags
# set(CMAKE_CXX_FLAGS  ${CMAKE_CXX_FLAGS}  "-std=c++11")

# Csound opcode build
find_package(Csound)

function(make_plugin pluginlib srcs)
  if(APPLE)
        add_library(${pluginlib} SHARED ${srcs})
    else()
        add_library(${pluginlib} MODULE ${srcs})
  endif()
  target_include_directories(${pluginlib} PRIVATE ${CSOUND_INCLUDE_DIRS})
endfunction(make_plugin)

if(CSOUND_FOUND)
  message(STATUS "Building Juno SYX Loader opcode")
  make_plugin(jsl src/jsl.c)
else()
  message(STATUS "Csound installation not found")
endif()
