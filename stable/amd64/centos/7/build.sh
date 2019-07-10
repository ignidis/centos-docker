#!/bin/sh
docker build --rm -t builder:centos-7 . && \
docker run --rm -it -d --name builder-centos-7 builder:centos-7 /bin/bash && \
docker export builder-centos-7 | docker import - cybearth/centos:7 && \
docker kill builder-centos-7 && \
docker rmi  builder:centos-7 centos:7
