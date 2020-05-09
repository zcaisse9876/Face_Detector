#!/bin/sh

echo "Checking for cmake..."
command -v cmake >/dev/null 2>&1 || { echo >&2 "Not Found!  Installing."; sudo apt-get install cmake; }
command -v cmake >/dev/null 2>&1 || { echo >&2 "cmake installation failed. fix manually and retry script!"; exit 1; }
echo "Complete!"

echo "Checking for Python..."
command -v python >/dev/null 2>&1 || { echo >&2 "Not Found!  Installing."; sudo apt-get install python python-pip; }
command -v python >/dev/null 2>&1 || { echo >&2 "Python installation failed. fix manually and retry script!"; exit 1; }
echo "Complete!"

echo "Checking for pip..."
command -v pip >/dev/null 2>&1 || { echo >&2 "Not Found!  Installing."; sudo apt-get install python-pip; }
command -v pip >/dev/null 2>&1 || { echo >&2 "pip installation failed. fix manually and retry script!"; exit 1; }
echo "Complete!"

echo "Checking for Numpy..."
python -c "import numpy" >/dev/null 2>&1 || { echo >&2 "Not Found! Installing."; pip install numpy; }
python -c "import numpy" >/dev/null 2>&1 || { echo >&2 "Numpy installation failed. fix manually and retry script"; exit 1; }
echo "Complete"

# echo "Installing Boost..."
# command -v wget >/dev/null 2>&1 || { echo >&2 "wget not Found!  Installing."; sudo apt-get install wget; }
# command -v wget >/dev/null 2>&1 || { echo >&2 "wget binary failed. fix manually and retry script!"; exit 1; }
# cd extern
# wget https://dl.bintray.com/boostorg/release/1.73.0/source/boost_1_73_0.tar.bz2
# command -v tar >/dev/null 2>&1 || { echo >&2 "tar not Found!  Installing."; sudo apt-get install tar; }
# command -v tar >/dev/null 2>&1 || { echo >&2 "tar binary failed. fix manually and retry script!"; exit 1; }
# tar --bzip2 -xf boost_1_73_0.tar.bz2
# rm boost_1_73_0.tar.bz2
# cd ..
# echo "Complete"

echo "Installing libx11 libraries..."
sudo apt-get install libx11-dev
echo "Complete"

# Dependency for dlib
echo "Installing OpenBLAS..."
sudo apt-get install libopenblas-dev liblapack-dev
echo "Complete..."

echo "Installing OpenCV Dependencies..."
sudo apt-get install libgtk2.0-dev libcanberra-gtk-module libcanberra-gtk3-module pkg-config
echo "Complete..."

echo "Building OpenCV..."
cd extern/opencv
cd build >/dev/null 2>&1 || { mkdir build && cd build; }
cmake -DCMAKE_BUILD_TYPE=Release -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules ..
make -j7
cd ../../../
echo "Complete" 

echo "Building Project"
cd build >/dev/null 2>&1 || { mkdir build && cd build; }
cmake -DOpenCV_DIR=../extern/opencv/build ../src
cmake --build .
cd ..
echo "Complete!"

echo "Creating Build Script"
echo "cd build && cmake -DOpenCV_DIR=../extern/opencv/build ../src && cmake --build ." > build.sh && sudo chmod +x build.sh
echo
echo "Installation Complete! To run: cd build && ./face_detector | To rebuild ./build.sh"


