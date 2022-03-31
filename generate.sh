#!/bin/bash

# https://en.wikipedia.org/wiki/ANSI_escape_code
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

printHelp() {
  printf "${NC}[*] ${GREEN}USAGE ${NC}\n"
  printf "${NC}[*] ${NC} \t Generates alpine with bash images ${NC}\n"
  printf "${NC}[*] ${GREEN}OPTIONS ${NC}\n"
  printf "${NC}[*] ${YELLOW} \t --registry-user [string]    ${NC}Set the registry user ${RED}mandatory ${NC}\n"
  printf "${NC}[*] ${YELLOW} \t --image-name [string]       ${NC}Set the image name ${RED}mandatory ${NC}\n"
  printf "${NC}[*] ${YELLOW} \t --bash-version [string]     ${NC}Set the bash version ${YELLOW}optional${NC}\n"
  printf "${NC}[*] ${YELLOW} \t --alpine-version [string]   ${NC}Set the alpine version ${YELLOW}optional${NC}\n"
  printf "${NC}[*] ${YELLOW} \t --image-version [string]    ${NC}Set the image version ${YELLOW}optional${NC}\n"
  printf "${NC}[*] ${YELLOW} \t --help                      ${NC}Shows this help message ${NC}\n"
  printf "${NC}[*] ${GREEN}EXAMPLES ${NC}\n"
  printf "${NC}[*] ${NC} \t Generate image for alpine with bash in specified version for bash and alpine \n"
  printf "${NC}[*] ${YELLOW} \t\t $ ./generate.sh --registry-user USER --image-name IMAGE --bash-version BASH_VERSION --alpine-version ALPINE_VERSION \n"
  printf "${NC}[*] ${NC} \t Generate image for alpine with bash in specified image version \n"
  printf "${NC}[*] ${YELLOW} \t\t $ ./generate.sh --registry-user USER --image-name IMAGE --image-version VERSION \n"
  printf "${NC}[*] ${NC} \t Generate image for alpine with bash in latest version \n"
  printf "${NC}[*] ${YELLOW} \t\t $ ./generate.sh --registry-user USER --image-name IMAGE \n"
}

while [[ $# -gt 0 ]]
do
key="$1"
case $key in
  --registry-user)
  REGISTRY_USER="$2"
  shift
  ;;
  --image-name)
  IMAGE_NAME="$2"
  shift
  ;;
  --bash-version)
  BASH_VERSION="$2"
  shift
  ;;
  --alpine-version)
  ALPINE_VERSION="$2"
  shift
  ;;
  --image-version)
  IMAGE_VERSION="$2"
  shift
  ;;
  -h|--help)
  printHelp
  exit 0
esac
shift
done

if [[ -n $REGISTRY_USER && -n $IMAGE_NAME ]]; then
  if [[ -n $BASH_VERSION && -n $ALPINE_VERSION ]]; then
    printf "${YELLOW}[*] ${GREEN}Generating image with bash $BASH_VERSION and alpine $ALPINE_VERSION version ${NC}\n"
    # docker build --build-arg ALPINE_VERSION=$VERSION -t alpine-bash:$VERSION .
    docker buildx build --platform linux/amd64,linux/386,linux/arm64,linux/arm/v7,linux/arm/v6 --build-arg BASH_VERSION=$BASH_VERSION --build-arg ALPINE_VERSION=$ALPINE_VERSION -t $REGISTRY_USER/$IMAGE_NAME:$BASH_VERSION-alpine$ALPINE_VERSION --push .
    printf "${YELLOW}[*] ${GREEN}Finished image for bash $BASH_VERSION and alpine $ALPINE_VERSION versions ${NC}\n"
  elif [[ -n $IMAGE_VERSION ]]; then
    printf "${YELLOW}[*] ${GREEN}Generating image with bash and alpine with $IMAGE_VERSION version ${NC}\n"
    # docker build -t alpine-bash:latest .
    docker buildx build --platform linux/amd64,linux/386,linux/arm64,linux/arm/v7,linux/arm/v6 --build-arg IMAGE_VERSION=$IMAGE_VERSION -t $REGISTRY_USER/$IMAGE_NAME:$IMAGE_VERSION --push .
    printf "${YELLOW}[*] ${GREEN}Finished image for bash and alpine with $IMAGE_VERSION version ${NC}\n"
  else
    printf "${YELLOW}[*] ${GREEN}Generating image for bash and alpine with latest version ${NC}\n"
    # printf "${YELLOW}[*] ${RED}Mandatory to launch also with --bash-version and --alpine-version or with --image-version ${NC}\n"
    docker buildx build --platform linux/amd64,linux/386,linux/arm64,linux/arm/v7,linux/arm/v6 --build-arg IMAGE_VERSION=latest -t $REGISTRY_USER/$IMAGE_NAME:latest --push .
    printf "${YELLOW}[*] ${GREEN}Finished image for bash and alpine with latest version ${NC}\n"
  fi
  exit 0
else
  printf "${YELLOW}[*] ${RED}Mandatory to launch with --registry-user and --image-name ${NC}\n"
  exit 1
fi
