cmake_minimum_required(VERSION 3.10)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

set(CMAKE_CXX_FLAGS "-Wall -Wextra")
set(CMAKE_CXX_FLAGS_DEBUG "-g")
set(CMAKE_CXX_FLAGS_RELEASE "-O3")

# set the project name
project( hello_cmake VERSION "0.0.1")

# set C++ standard
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Pass application info to config header file
configure_file( ../include/config.h.in config.h )


# output executable
add_executable( hello_cmake main.cpp )



# include binary dir to use config.h created above
target_include_directories( hello_cmake PUBLIC "${PROJECT_BINARY_DIR}" )
