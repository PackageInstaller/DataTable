#!/bin/sh
set -e
cd "$(dirname "$0")"
mkdir -p build
find src/unluac -name '*.java' | xargs javac -encoding UTF-8 -d build
jar cfm unluac-ptn.jar MANIFEST.MF -C build unluac
echo "built $(pwd)/unluac-ptn.jar"
