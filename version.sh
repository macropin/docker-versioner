#!/usr/bin/env bash

cd $1
VERSION=$(git describe --tags --long)
echo "Version Tag is: $VERSION"
echo $VERSION > version/number

