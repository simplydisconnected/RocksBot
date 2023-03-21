#!/usr/bin/env bash 

exec docker create --volume "$(pwd)/etc":/RocksBot/etc --volume "$(pwd)/data":/RocksBot/data --name rocksbot rocksbot
