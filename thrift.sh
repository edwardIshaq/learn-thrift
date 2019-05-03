#!/bin/bash
docker run --rm \
	-v `pwd`:`pwd` -w `pwd` \
	thrift:0.12 \
	thrift ${@:1}
