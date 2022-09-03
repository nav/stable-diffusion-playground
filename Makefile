SHELL := /bin/bash
.DEFAULT_GOAL := help

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

.PHONY: help install


help:			## Show this help
	@printf "\nUsage: make <command>\n\nThe following commands are available:\n\n"
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/ [a-z\/]*	//' | sed -e 's/##//'
	@printf "\n"

install:		## Create virtual environment and install dependencies
	@nix-shell --run "python -m venv .venv \
	&& git clone -b apple-silicon-mps-support https://github.com/bfirsh/stable-diffusion.git \
	&& mkdir -p stable-difussion/models/ldm/stable-diffusion-v1/ \
	&& source .venv/bin/activate  \
	&& pip install -r stable-diffusion/requirements.txt \
	&& echo 'Install finished. Next step is to download the model from https://huggingface.co/CompVis/stable-diffusion-v-1-4-original and place it as stable-difussion/models/ldm/stable-diffusion-v1/model.ckpt'"

