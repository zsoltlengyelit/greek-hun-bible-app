#!/bin/sh
pushd ./dart_protoc_plugin
pub install
popd
protoc -I=. --plugin=./dart_protoc_plugin/bin/protoc-gen-dart --dart_out=../lib/protobuf ./chapter.proto