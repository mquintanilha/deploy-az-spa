#!/bin/bash

docker build . \
--file Dockerfile \
--tag ${PKG}:${TAG}