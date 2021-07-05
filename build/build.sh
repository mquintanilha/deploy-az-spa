#!/bin/bash

docker build . \
--file Dockerfile \
--tag ${PKG}_${COMMIT_SHA}:${TAG}