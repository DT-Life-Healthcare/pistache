#!/bin/bash

#
# SPDX-FileCopyrightText: 2024 Duncan Greatwood
#
# SPDX-License-Identifier: Apache-2.0
#

# Complains can't find GTest, doesn't seem to matter
# Can also build without rapidjson apparently (despite complaint)

# To install (must be run from build directory):
#   sudo make install

source ./cmksetdirvars.sh

if [ -e "./${CMAKE_BUILD_DIR}" ]
then
    cd "${CMAKE_BUILD_DIR}"
else
    mkdir "${CMAKE_BUILD_DIR}"
    cd "${CMAKE_BUILD_DIR}"
fi

if [ "$(uname)" == "Darwin" ]; then
    # on macOS, rapidjson has been installed via brew
   cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ..
else
    if [ -e "../rapidjson/build" ]
    then
        cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DRapidJSON_DIR=../rapidjson/build/ ..
    else
        cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ..
    fi
fi

make
