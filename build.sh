#!/bin/bash
nodev=18
npmv=10

parse_args() {
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            --nodev) nodev="$2"; shift ;;
            --npmv) npmv="$2"; shift ;;
            --help|-h)
                echo "Usage: $0 [--nodev <node version>] [--npmv <npm version>]"
                exit 0
                ;;
            *)
                echo "Unknown parameter: $1"
                exit 1
                ;;
        esac
        shift
    done
}

parse_args "$@"

docker build -f dockerfiles/Dockerfile.base -t nvm-node-base .

docker buildx build -f dockerfiles/Dockerfile.node \
  -t nvm-node:"$nodev" \
  --build-arg NODE_VERSION="$nodev" \
  --build-arg NPM_VERSION="$npmv" \
  .