<div style="display: -ms-flexbox; display: -webkit-flex; display: flex; -webkit-flex-direction: row; -ms-flex-direction: row; flex-direction: row; -webkit-flex-wrap: wrap; -ms-flex-wrap: wrap; flex-wrap: wrap; -webkit-justify-content: center; -ms-flex-pack: center; justify-content: center; -webkit-align-content: center; -ms-flex-line-pack: center; align-content: center; -webkit-align-items: center; -ms-flex-align: center; align-items: center;">
  <img style="-webkit-order: 0; -ms-flex-order: 0; order: 0; -webkit-flex: 0 1 auto; -ms-flex: 0 1 auto; flex: 0 1 auto; -webkit-align-self: auto; -ms-flex-item-align: auto; align-self: auto;" src="icon.png" />
</div>

<h1 style="text-align:center;">Alpine with bash images generator</h1>


## What is this?
A script and base Dockerfile to generate alpine image with bash shell

## How to use it?
The script contain a --help option that can describe how to use each of them.

```bash
./generate.sh --version 3.13.4
```

```bash
./generate.sh
```

```bash
[*] USAGE 
[*]  	 Generate alpine image with bash 
[*] OPTIONS 
[*]  	 --version [string]   Set the version alpine image version to generate, optional 
[*]  	 --help               Shows this help message 
[*] EXAMPLES 
[*]  	 Generate alpine image with bash shell in specified version 
[*]  		 $ ./generate.sh --version 3.12.6 
[*]  	 Generate alpine image with bash shell in latest version 
[*]  		 $ ./generate.sh
```

Powered by <a href="https://xisco.dev" target="_blank">xiscodev</a>
