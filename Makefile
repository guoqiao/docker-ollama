# ollama

# change your model here, or override with env var $MODEL
# ref: https://ollama.com/library
MODEL ?= deepseek-r1:8b

# pass --gpus=all only when nvidia-smi available
gpus := $(shell which nvidia-smi > /dev/null && echo "--gpus=all" || echo "")

init:
	touch .env

serve: init
	docker run -d ${gpus} \
		--pull=always \
		--env-file .env \
		-v ollama:/root/.ollama \
		-v .:/workspace \
		--workdir /workspace \
		-p 11434:11434 \
		--name ollama \
		ollama/ollama

stop:
	docker rm -f ollama

shell:
	docker exec -it ollama bash

list:
	docker exec -it ollama ollama list

ps:
	docker exec -it ollama ollama ps

pull:
	docker exec -it ollama ollama pull ${MODEL}

run:
	docker exec -it ollama ollama run ${MODEL}

rm:
	docker exec -it ollama ollama rm ${MODEL}

# aider

aider-conda-env:
	conda create -n aider python=3.12 aider-install aider-chat

aider-install:
	python -m pip install -U pip
	python -m pip install -U aider-install aider-chat
	aider-install

aider-model: pull
	OLLAMA_API_BASE=http://127.0.0.1:11434 aider --model ollama_chat/${MODEL}


# vscode cli/server/tunnel

url := 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' 
pkg := code.tar.gz

vscode-download:
	curl -Lsk ${url} -o ${pkg}
	tar -xf ${pkg}
	rm -rf ${pkg}
	ls -lh ./code

vscode-tunnel:
	# run tunnel in tmux session so it can keep running in background
	tmux new-session -s vscode "./code tunnel"
