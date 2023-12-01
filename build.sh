#!/bin/bash

CPP_SOURCE_DIR="/app/cpp"


echo "starting arrow cpp build from source dir: ${CPP_SOURCE_DIR}"
cd "${CPP_SOURCE_DIR}"
mkdir build
cd build
cmake .. \
        -DARROW_DEPENDENCY_SOURCE=BUNDLED \
        -DARROW_BUILD_TESTS=OFF \
        -DARROW_BUILD_UTILITIES=OFF \
        -DARROW_COMPUTE=ON \
        -DARROW_CSV=ON \
        -DARROW_CUDA=OFF \
        -DARROW_DATASET=ON \
        -DARROW_FILESYSTEM=ON \
        -DARROW_HDFS=ON \
        -DARROW_JSON=ON \
        -DARROW_FLIGHT=OFF \
        -DARROW_FLIGHT_SQL=OFF \
        -DARROW_GANDIVA=OFF \
        -DARROW_GANDIVA_JAVA=OFF \
        -DARROW_GCS=OFF \
        -DARROW_JEMALLOC=ON \
        -DARROW_MIMALLOC=OFF \
        -DARROW_ORC=OFF \
        -DARROW_PARQUET=ON \
        -DPARQUET_REQUIRE_ENCRYPTION=OFF \
        -DARROW_S3=ON \
        -DARROW_SUBSTRAIT=OFF \
        -DARROW_WITH_RE2=ON \
        -DARROW_WITH_UTF8PROC=ON \
        -DARROW_TENSORFLOW=OFF
make -j8
make install

echo "arrow cpp has been built successfully"

PY_EXE=$1
PY_SOURCE_DIR="/app/python"
PY_PROJECT_NAME="minimal-pyarrow-unofficial"


echo "building wheel for python executable: ${PY_EXE}"

cd "${PY_SOURCE_DIR}"

# Substitute the minimal library name for the pyarrow project name
sed -i "s/name='pyarrow'/name='${PY_PROJECT_NAME}'/" setup.py

# Build with minimal options. The options used are controlled primarily through
# environment variables.
PYARROW_INSTALL_TESTS=0 \
PYARROW_WITH_PARQUET=1 \
PYARROW_WITH_S3=1 \
PYARROW_WITH_DATASET=1 \
PYARROW_BUNDLE_ARROW_CPP=1 \
PYARROW_BUNDLE_CYTHON_CPP=1 \
    python3 -m build

echo "wheel for ${PY_EXE} has been built sucessfully"

