#!/bin/sh

echo "Checking for Homebrew..."
command -v brew >/dev/null 2>&1 || { echo >&2 "Not Found!  Installing."; /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"; }
command -v brew >/dev/null 2>&1 || { echo >&2 "Homebrew installation failed. fix manually and retry script!"; exit 1; }
echo "Complete!"

echo "Checking for cmake..."
command -v cmake >/dev/null 2>&1 || { echo >&2 "Not Found!  Installing."; brew install cmake; }
command -v cmake >/dev/null 2>&1 || { echo >&2 "cmake installation failed. fix manually and retry script!"; exit 1; }
echo "Complete!"

echo "Checking for Python..."
command -v python >/dev/null 2>&1 || { echo >&2 "Not Found!  Installing."; brew install python; }
command -v python >/dev/null 2>&1 || { echo >&2 "Python installation failed. fix manually and retry script!"; exit 1; }
echo "Complete!"

echo "Checking for Numpy..."
python -c "import numpy" >/dev/null 2>&1 || { echo >&2 "Not Found! Installing."; pip install numpy; }
python -c "import numpy" >/dev/null 2>&1 || { echo >&2 "Numpy installation failed. fix manually and retry script"; exit 1; }
echo "Complete"

echo "Checking for Boost..."
brew list boost >/dev/null 2>&1 || { echo >&2 "Not Found! Installing."; brew install boost; }
brew list boost >/dev/null 2>&1 || { echo >&2 "numpy installation failed. fix manually and retry script"; exit 1; }
echo "Complete"

echo "Checking for XQuartz..."
brew cask list xquartz >/dev/null 2>&1 || { echo >&2 "Not Found! Installing."; brew cask install xquartz; }
brew cask list xquartz >/dev/null 2>&1 || { echo >&2 "XQuartz installation failed. fix manually and retry script"; exit 1; }
echo "Complete"

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


