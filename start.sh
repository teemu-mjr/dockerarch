#!/bin/bash
sudo docker run \
  -v /:/root/host \
  --rm \
  -it \
  dockerarch \
  fish
