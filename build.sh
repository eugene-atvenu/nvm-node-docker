#!/bin/bash
nodev=18
npmv=10
pm2=false

parse_args() {
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            --node) nodev="$2"; shift ;;
            --npm) npmv="$2"; shift ;;
            --pm2) pm2="$2"; shift ;;
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

docker build -f dockerfiles/Dockerfile.nvm-base -t node-nvm-base --platform linux/amd64 .

ispm=$([ "$pm2" = "true" ] && echo "pm2" || echo "build")

docker buildx build -f dockerfiles/Dockerfile.node \
  --platform linux/amd64 \
  -t atvenu/node-nvm:"$ispm-node_$nodev"-npm_"$npmv" \
  --build-arg NODE_VERSION="$nodev" \
  --build-arg NPM_VERSION="$npmv" \
  --build-arg INSTALL_PM2="$pm2" \
  .