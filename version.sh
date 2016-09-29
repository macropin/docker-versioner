#!/usr/bin/env bash

pushd $1
VERSION=$(git describe --tags --long)
popd
echo "Version Tag is: $VERSION"
echo $VERSION > version/number

