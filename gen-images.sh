#!/bin/bash

# https://en.wikipedia.org/wiki/ANSI_escape_code
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# PLATFORMS
PC="linux/amd64,linux/i386"
ARM="linux/arm64/v8,linux/arm/v7,linux/arm/v6"
FULL=$PC","$ARM

printHelp() {
  printf "${NC}[*] ${GREEN}USAGE ${NC}\n"
  printf "${NC}[*] ${NC} \t Generates alpine with bash images ${NC}\n"
  printf "${NC}[*] ${GREEN}OPTIONS ${NC}\n"
  printf "${NC}[*] ${YELLOW} \t --registry-user [string]    ${NC}Set the registry user ${RED}mandatory ${NC}\n"
  printf "${NC}[*] ${YELLOW} \t --image-name [string]       ${NC}Set the image name ${RED}mandatory ${NC}\n"
  printf "${NC}[*] ${YELLOW} \t --platforms-list [string]   ${NC}Set the platforms to build ${RED}mandatory ${NC}\n"
  printf "${NC}[*] ${YELLOW} \t --bash-version [string]     ${NC}Set the bash version ${YELLOW}optional${NC}\n"
  printf "${NC}[*] ${YELLOW} \t --alpine-version [string]   ${NC}Set the alpine version ${YELLOW}optional${NC}\n"
  printf "${NC}[*] ${YELLOW} \t --image-version [string]    ${NC}Set the image version ${YELLOW}optional${NC}\n"
  printf "${NC}[*] ${YELLOW} \t --help                      ${NC}Shows this help message ${NC}\n"
  printf "${NC}[*] ${GREEN}EXAMPLES ${NC}\n"
  printf "${NC}[*] ${NC} \t Generate image for alpine with bash in specified version for bash and alpine \n"
  printf "${NC}[*] ${YELLOW} \t\t $ ./gen-images.sh --registry-user USER --image-name IMAGE --platforms-list pc --bash-version BASH_VERSION --alpine-version ALPINE_VERSION \n"
  printf "${NC}[*] ${NC} \t Generate image for alpine with bash in specified image version \n"
  printf "${NC}[*] ${YELLOW} \t\t $ ./gen-images.sh --registry-user USER --image-name IMAGE --platforms-list arm --image-version VERSION \n"
  printf "${NC}[*] ${NC} \t Generate image for alpine with bash in latest version \n"
  printf "${NC}[*] ${YELLOW} \t\t $ ./gen-images.sh --registry-user USER --image-name IMAGE --platforms-list full \n"
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
  --platforms-list)
  PLATFORMS_LIST="$2"
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

PLATFORMS=""

if [[ -n $REGISTRY_USER && -n $IMAGE_NAME && -n $PLATFORMS_LIST ]]; then
  if [[ $PLATFORMS_LIST == "pc" ]]; then
    PLATFORMS=$PC
  elif [[ $PLATFORMS_LIST == "arm" ]]; then
    PLATFORMS=$ARM
  elif [[ $PLATFORMS_LIST == "full" ]]; then
    PLATFORMS=$FULL
  else
    printf "${YELLOW}[*] ${RED}Param --platforms-list should be 'pc', 'arm' or 'full' ${NC}\n"
    printHelp
    exit 1
  fi

  if [[ -n $BASH_VERSION && -n $ALPINE_VERSION ]]; then
    printf "${YELLOW}[*] ${GREEN}Generating image with bash $BASH_VERSION and alpine $ALPINE_VERSION version ${NC}\n"
    # docker build --build-arg BASH_VERSION=$BASH_VERSION --build-arg ALPINE_VERSION=$ALPINE_VERSION -t $REGISTRY_USER/$IMAGE_NAME:$BASH_VERSION-alpine$ALPINE_VERSION .
    docker buildx build --platform $PLATFORMS --build-arg BASH_VERSION=$BASH_VERSION --build-arg ALPINE_VERSION=$ALPINE_VERSION -t $REGISTRY_USER/$IMAGE_NAME:$BASH_VERSION-alpine$ALPINE_VERSION --push .
    printf "${YELLOW}[*] ${GREEN}Finished image for bash $BASH_VERSION and alpine $ALPINE_VERSION versions ${NC}\n"
  elif [[ -n $IMAGE_VERSION ]]; then
    printf "${YELLOW}[*] ${GREEN}Generating image with bash and alpine with $IMAGE_VERSION version ${NC}\n"
    # docker build --build-arg IMAGE_VERSION=$IMAGE_VERSION -t $REGISTRY_USER/$IMAGE_NAME:$IMAGE_VERSION .
    docker buildx build --platform $PLATFORMS --build-arg IMAGE_VERSION=$IMAGE_VERSION -t $REGISTRY_USER/$IMAGE_NAME:$IMAGE_VERSION --push .
    printf "${YELLOW}[*] ${GREEN}Finished image for bash and alpine with $IMAGE_VERSION version ${NC}\n"
  else
    printf "${YELLOW}[*] ${GREEN}Generating image for bash and alpine with latest version ${NC}\n"
    # docker build -t $REGISTRY_USER/$IMAGE_NAME:latest .
    docker buildx build --platform $PLATFORMS -t $REGISTRY_USER/$IMAGE_NAME:latest --push .
    printf "${YELLOW}[*] ${GREEN}Finished image for bash and alpine with latest version ${NC}\n"
  fi
  exit 0
else
  printf "${YELLOW}[*] ${RED}Mandatory to launch with --registry-user, --image-name and --builder ${NC}\n"
  printHelp
  exit 1
fi
