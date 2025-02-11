# docker-ollama

A simple scaffold to run specified model with ollama in docker, and optionally interact with it via aider and vscode tunnel.

You can drop the `Makefile` to any machine with docker to start use this.

Tested on Debian/Ubuntu Linux, and macOS.

Quick start:

```
# edit the model in Makefile, or override with envvar $MODEL
# export MODEL=deepseek-r1:14b
make serve
make pull
make aider-install
make aider-model
```

If ollama is running on a machine without public IP, you can also use vscode tunnel to access it:
```
make vscode-download
make vscode-tunnel
# now follow the msg on screen to login
# on another machine, open vscode, Connect to Tunnel
```

See Makefile for more cmds.