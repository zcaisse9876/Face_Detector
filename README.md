# Face Detector

This is the C++ based image processing application for real-time facial and landmark detection with OpenCV and Dlib. There are future plans to integrate tensorflow for other facial detection features in the future. This serves as an easy starting template for setting up real-time facial detection and image-processing using OpenCV in C++.

---

### Technology Stack

* **C++ Standard**: [14](https://en.cppreference.com/w/cpp/14)
* **Build System Generator**: [CMake](https://cmake.org/)
* **Compiler**: [g++](https://gcc.gnu.org/)

### File Structure
Below is a brief explanation of the directory structure.

```bash
.
├── src           <-- .cpp source files
│   └── ...         
├── extern        <-- External dependencies / git submodules
│   └── ...
├── assets        <-- Assets / models needed for application
│   └── ...
├── include       <-- .h header files for source
│   └── ...
├── *_install.sh  <-- system specific initial build / settup file
│   └── ...
└── ...
```
```

----

## Local Development

### Prerequisites
- All prerequisites for building are specified in your systems respective *_install.sh file. While these files are tested working bash scripts
as of 5/9/20, It is likely that packages managers / commands use will change in the future. If youre the install script fails, it can
simply be used as guide for which software that must be manually installed

### Build Setup / Installing Dependencies / Running

```bash
# build/install dependencies using install script
sudo chmod +x ${Your_system}_install.sh && ./${Your_system}_install.sh

# Run compiled output
cd build && ./face_detector
```
```

---

### Building
To build an executable installer of the Bird application you would simple run:
```bash
#Run compiled script
./build.sh

#Or
cd build
cmake -DOpenCV_DIR=../libs/opencv/build ../src
cmake --build .
```
```
