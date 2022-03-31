<div style="display: -ms-flexbox; display: -webkit-flex; display: flex; -webkit-flex-direction: row; -ms-flex-direction: row; flex-direction: row; -webkit-flex-wrap: wrap; -ms-flex-wrap: wrap; flex-wrap: wrap; -webkit-justify-content: center; -ms-flex-pack: center; justify-content: center; -webkit-align-content: center; -ms-flex-line-pack: center; align-content: center; -webkit-align-items: center; -ms-flex-align: center; align-items: center;">
  <img style="-webkit-order: 0; -ms-flex-order: 0; order: 0; -webkit-flex: 0 1 auto; -ms-flex: 0 1 auto; flex: 0 1 auto; -webkit-align-self: auto; -ms-flex-item-align: auto; align-self: auto;" src="icon.png" />
</div>

<h1 style="text-align:center;">Alpine with bash images generator</h1>


## What is this?
A script and base Dockerfile to generate alpine image with bash shell

## How to use it?
The script contain a --help option that can describe how to use each of them.

```bash
./generate.sh --registry-user DOCKER_USER --image-name DOCKER_IMAGE_NAME --bash-version BASH_VERSION --alpine-version ALPINE_VERSION
```

```bash
./generate.sh --help
```

```bash
[*] USAGE
[*]  	 Generates alpine with bash images
[*] OPTIONS
[*]  	 --registry-user [string]    Set the registry user mandatory
[*]  	 --image-name [string]       Set the image name mandatory
[*]  	 --bash-version [string]     Set the bash version optional
[*]  	 --alpine-version [string]   Set the alpine version optional
[*]  	 --image-version [string]    Set the image version optional
[*]  	 --help                      Shows this help message
[*] EXAMPLES
[*]  	 Generate image for alpine with bash in specified version for bash and alpine
[*]  		 $ ./generate.sh --registry-user USER --image-name IMAGE --bash-version BASH_VERSION --alpine-version ALPINE_VERSION
[*]  	 Generate image for alpine with bash in specified image version
[*]  		 $ ./generate.sh --registry-user USER --image-name IMAGE --image-version VERSION
[*]  	 Generate image for alpine with bash in latest version
[*]  		 $ ./generate.sh --registry-user USER --image-name IMAGE
```

Powered by <a href="https://xisco.dev" target="_blank">xiscodev</a>
