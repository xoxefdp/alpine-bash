#!/bin/bash

# https://en.wikipedia.org/wiki/ANSI_escape_code
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

printHelp() {
  printf "${NC}[*] ${GREEN}USAGE ${NC}\n"
  printf "${NC}[*] ${NC} \t Generate alpine image with bash ${NC}\n"
  printf "${NC}[*] ${GREEN}OPTIONS ${NC}\n"
  printf "${NC}[*] ${YELLOW} \t --version [string]   ${NC}Set the version alpine image version to generate, optional ${NC}\n"
  printf "${NC}[*] ${YELLOW} \t --help               ${NC}Shows this help message ${NC}\n"
  printf "${NC}[*] ${GREEN}EXAMPLES ${NC}\n"
  printf "${NC}[*] ${NC} \t Generate alpine image with bash shell in specified version \n"
  printf "${NC}[*] ${YELLOW} \t\t $ ./generate.sh --version 3.12.6 \n"
  printf "${NC}[*] ${NC} \t Generate alpine image with bash shell in latest version \n"
  printf "${NC}[*] ${YELLOW} \t\t $ ./generate.sh \n"
}

while [[ $# -gt 0 ]]
do
key="$1"
case $key in
  --version)
  VERSION="$2"
  shift
  ;;
  -h|--help)
  printHelp
  exit 0
esac
shift
done

if [[ -n $VERSION ]]; then
  printf "${YELLOW}[*] ${GREEN}Generating image with alpine $VERSION version ${NC}\n"
  docker build --build-arg ALPINE_VERSION=$VERSION -t alpine-bash:$VERSION .
  printf "${YELLOW}[*] ${GREEN}Finished alpine image with $VERSION version ${NC}\n"
else
  printf "${YELLOW}[*] ${GREEN}Generating image with alpine latest version ${NC}\n"
  docker build -t alpine-bash:latest .
  printf "${YELLOW}[*] ${GREEN}Finished alpine image with latest version ${NC}\n"
fi

exit 0