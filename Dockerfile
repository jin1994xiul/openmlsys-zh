#!/usr/bin/env -S sh -c 'docker build --rm -t book:snapshot -f $0 `dirname $0`'
FROM ubuntu:focal

ADD sources.list.focal.azure /etc/apt/sources.list
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y python3-pip git pandoc
RUN python3 -m pip install setuptools

ADD requirements.txt .
RUN python3 -m pip install -r requirements.txt
RUN git clone https://github.com/d2l-ai/d2l-book.git && cd d2l-book && python3 -m pip install .

WORKDIR /src
ADD . .

RUN d2lbook build html
