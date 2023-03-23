#!/usr/bin/env bash 

exec docker create --volume "$(pwd)":/RocksBot/ --name rocksbot rocksbot
