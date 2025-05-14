docker build -f dockerfiles/Dockerfile.base -t nvm-node-base .

docker buildx build -f dockerfiles/Dockerfile.node \
  -t nvm-node:18 \
  -t nvm-node:default \
  --build-arg NODE_VERSION=18 \
  --build-arg NPM_VERSION=10 \
  .

docker buildx build -f dockerfiles/Dockerfile.node \
  -t nvm-node:16 \
  -t nvm-node:depricated \
  --build-arg NODE_VERSION=16 \
  --build-arg NPM_VERSION=6 \
  .

docker buildx build -f dockerfiles/Dockerfile.node \
  -t nvm-node:20 \
  --build-arg NODE_VERSION=20 \
  --build-arg NPM_VERSION=10 \
  .
