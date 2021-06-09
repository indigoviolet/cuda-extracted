#!/bin/bash
# Prelude



# [[file:build.org::*Prelude][Prelude:1]]
set -eux
# Prelude:1 ends here

# Make build dir


# [[file:build.org::*Make build dir][Make build dir:1]]
set -eux

BUILD_DIR=$(realpath .)/build
OUTPUT_DIR=$(realpath .)/output
mkdir -p $BUILD_DIR
mkdir -p $OUTPUT_DIR

echo $BUILD_DIR
echo $OUTPUT_DIR
# Make build dir:1 ends here

# Download and extract deb

# Choose the right deb here

# https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=20.04&target_type=deb_local


# [[file:build.org::*Download and extract deb][Download and extract deb:1]]
cd $BUILD_DIR

DOWNLOAD_URL='https://developer.download.nvidia.com/compute/cuda/11.3.1/local_installers/cuda-repo-ubuntu2004-11-3-local_11.3.1-465.19.01-1_amd64.deb'
curl -O -C - $DOWNLOAD_URL

DEB_NAME=$(fd '.deb' -x echo \{/\} | head -n1)
echo $DEB_NAME

EXTRACT_DIR=extracted/$DEB_NAME
mkdir -p $EXTRACT_DIR

dpkg-deb -x $DEB_NAME $EXTRACT_DIR
# Download and extract deb:1 ends here

# Find components we want and extract them to output_dir


# [[file:build.org::*Find components we want and extract them to output_dir][Find components we want and extract them to output_dir:1]]
mkdir -p $OUTPUT_DIR/$DEB_NAME

fd 'cuda-cudart-dev.*\.deb' extracted/$DEB_NAME -x dpkg-deb -x {} $OUTPUT_DIR/$DEB_NAME/{/}

echo "You can delete $BUILD_DIR"
# Find components we want and extract them to output_dir:1 ends here
