#! /usr/bin/make -f
VENV        := $(CURDIR)/venv
PYTHON_BIN  ?= $(VENV)/bin/python3
PIP_BIN     ?= $(VENV)/bin/pip
APP			?= app.py

help:  ## This help dialog.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

bootstrap:  ## Bootstrap project or fix existing copy
	sudo apt update
	cat requirements.apt | xargs sudo apt install -y
	python3 -m venv venv
	$(PIP_BIN) install -r requirements.txt

upgradevenv:  ## Upgrade python3 virtualenv
	python3 -m venv --upgrade venv

run:  ## Start development version of application
	$(PYTHON_BIN) $(APP)

tests:  ## Run applications tests
	$(PYTHON_BIN) -m pytest tests/

commit:  ## Deploy, test, commit changes to git and push on github
	bash ./.devbin/bigcommit.sh
