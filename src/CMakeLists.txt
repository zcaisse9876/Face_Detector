cmake_minimum_required(VERSION 3.10)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

set(CMAKE_CXX_FLAGS "-Wall -Wextra")
set(CMAKE_CXX_FLAGS_DEBUG "-g")
set(CMAKE_CXX_FLAGS_RELEASE "-O3")
set(PROJECT_NAME "face_detector")
set(Header_INCLUDE_DIRS "../include")

# set the project name
project( ${PROJECT_NAME} VERSION "0.0.1")
include_directories( ../include )

# set C++ standard
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# adding dlib modules directory as sub directories
add_subdirectory(../extern/dlib/dlib dlib_build)

# Pass application info to config header file
configure_file( ../include/config.h.in config.h )

# Must add environment variable OpenCV_DIR that points to library build location
find_package( OpenCV REQUIRED )
include_directories( ${OpenCV_INCLUDE_DIRS} )

# output executable
add_executable( ${PROJECT_NAME} main.cpp DNNFaceDetector.cpp )

target_link_libraries( ${PROJECT_NAME} ${OpenCV_LIBS} dlib::dlib )

# include binary dir to use config.h created above
target_include_directories( ${PROJECT_NAME} PUBLIC "${PROJECT_BINARY_DIR}" )
