#/**
# * TangoMan Flask Boilerplate
# *
# * Deploy a Flask app easily
# *
# * @version  0.1.0
# * @author   "Matthias Morin" <mat@tangoman.io>
# * @licence  MIT
# * @link     https://github.com/TangoMan75/flask-boilerplate
# * @link     https://www.linkedin.com/in/morinmatthias
# */

.PHONY: help install run freeze dev-install check-install up serve stop venv-run venv-create venv-start venv-stop venv-install venv-remove venv-up venv-serve venv-kill 

# Colors
TITLE     = \033[1;42m
CAPTION   = \033[1;44m
BOLD      = \033[1;34m
LABEL     = \033[1;32m
DANGER    = \033[31m
SUCCESS   = \033[32m
WARNING   = \033[33m
SECONDARY = \033[34m
INFO      = \033[35m
PRIMARY   = \033[36m
DEFAULT   = \033[0m
NL        = \033[0m\n

# file name
filename?=app.py

# virtualenv name
virtualenv?=venv

# app port
port?=8080

# Local operating system (Windows_NT, Darwin, Linux)
ifeq ($(OS),Windows_NT)
	SYSTEM=$(OS)
else
	SYSTEM=$(shell uname -s)
endif

## Print this help
help:
	@printf "${TITLE} TangoMan Flask Boilerplate ${NL}\n"

	@printf "${CAPTION} Description:${NL}"
	@printf "${WARNING} Manage your Flask application with virtualenv easily${NL}\n"

	@printf "${CAPTION} Usage:${NL}"
	@printf "${WARNING} make [command] `awk -F '?' '/^[ \t]+?[a-zA-Z0-9_-]+[ \t]+?\?=/{gsub(/[ \t]+/,"");printf"%s=[%s]\n",$$1,$$1}' ${MAKEFILE_LIST}|sort|uniq|tr '\n' ' '`${NL}\n"

	@printf "${CAPTION} Config:${NL}"
	$(eval CONFIG:=$(shell awk -F '?' '/^[ \t]+?[a-zA-Z0-9_-]+[ \t]+?\?=/{gsub(/[ \t]+/,"");printf"$${PRIMARY}%-12s$${DEFAULT} $${INFO}$${%s}$${NL}\n",$$1,$$1}' ${MAKEFILE_LIST}|sort|uniq))
	@printf " ${CONFIG}\n"

	@printf "${CAPTION} Commands:${NL}"
	@awk '/^### /{printf"\n${BOLD}%s${NL}",substr($$0,5)} \
	/^[a-zA-Z0-9_-]+:/{HELP="";if(match(PREV,/^## /))HELP=substr(PREV, 4); \
		printf " ${LABEL}%-12s${DEFAULT} ${PRIMARY}%s${NL}",substr($$1,0,index($$1,":")),HELP \
	}{PREV=$$0}' ${MAKEFILE_LIST}

##################################################
### Python Flask
##################################################

## Deploy and start Flask app locally with one command
up: install serve

## Open default browser Serve app with gunicorn at localhost
serve:
	@printf "${INFO}app listening here: http://localhost:${port}${NL}"
	@printf "${INFO}gunicorn --bind 0.0.0.0:${port} `basename ${filename} .py`:`basename ${filename} .py`${NL}"
	@gunicorn --bind 0.0.0.0:${port} `basename ${filename} .py`:`basename ${filename} .py`

## Kill gunicorn server
stop:
	@printf "${INFO}pkill gunicorn${NL}"
	-@pkill gunicorn

## Restart app
restart: stop serve

##################################################
### Python3 CLI
##################################################

## Install
install:
	@printf "${INFO}pip3 install --upgrade pip${NL}"
	@pip3 install --upgrade pip
	@printf "${INFO}pip3 install -r requirements.txt${NL}"
	@pip3 install -r requirements.txt

## Start app
run:
	@printf "${INFO}python3 ${filename}${NL}"
	@python3 ${filename}

## Generate requirements.txt
freeze:
	@printf "${INFO}pip3 freeze > requirements.txt${NL}"
	@pip3 freeze > requirements.txt

##################################################
### Python Virtualenv Flask
##################################################

## Deploy and start your Flask app in fresh virtualenv with one command
venv-up: venv-create
	@printf "${INFO}sleep 1${NL}"
	@sleep 1
	-@make --no-print-directory venv-serve

## Serve app with gunicorn from virtualenv
venv-serve:
ifeq ($(shell test -f ${virtualenv}/bin/gunicorn && echo true),true)
	@printf "${INFO}app listening here: http://localhost:${port}${NL}"
	@printf "${INFO}${virtualenv}/bin/gunicorn --bind 0.0.0.0:${port} `basename ${filename} .py`:`basename ${filename} .py`${NL}"
	@${virtualenv}/bin/gunicorn --bind 0.0.0.0:${port} `basename ${filename} .py`:`basename ${filename} .py`
else
	@printf "${DANGER}error: virtualenv not found${NL}"
	@exit 0
endif

## Kill gunicorn server and remove virtualenv
venv-kill: stop venv-remove

##################################################
### Python Virtualenv
##################################################

## Start
venv-run:
ifeq ($(shell test -f ${virtualenv}/bin/python && echo true),true)
	@printf "${INFO}venv/bin/python ${filename}${NL}"
	@venv/bin/python ${filename}
else
	@printf "${DANGER}error: virtualenv not found${NL}"
	@exit 0
endif

## Create virtualenv
venv-create: venv-remove
	@printf "${INFO}virtualenv -p python3 ${virtualenv}${NL}"
	@virtualenv -p python3 ${virtualenv}
	@printf "${INFO}echo ${virtualenv} >> .gitignore${NL}"
	@echo ${virtualenv} >> .gitignore
	-@make --no-print-directory venv-start
	-@make --no-print-directory venv-install

## Activate virtualenv
venv-start:
ifeq ($(shell test -f ${virtualenv}/bin/activate && echo true),true)
	@printf "${INFO}source ${virtualenv}/bin/activate${NL}"
	@source ${virtualenv}/bin/activate
else
	@printf "${DANGER}error: virtualenv not found${NL}"
	@exit 0
endif

## Deactivate virtualenv
venv-stop:
	@printf "${INFO}bash -c \"source ${virtualenv}/bin/activate && deactivate\"${NL}"
	-@bash -c "source ${virtualenv}/bin/activate && deactivate"

## Install in virtualenv
venv-install:
ifeq ($(shell test -f ${virtualenv}/bin/pip && echo true),true)
	@printf "${INFO}${virtualenv}/bin/pip install -r requirements.txt${NL}"
	@${virtualenv}/bin/pip install -r requirements.txt
else
	@printf "${DANGER}error: virtualenv not found${NL}"
	@exit 0
endif

## Remove virtualenv
venv-remove: venv-stop
	@printf "${INFO}rm -rf ${virtualenv}${NL}"
	@rm -rf ${virtualenv}
	@printf "${INFO}rm -rf __pycache__${NL}"
	@rm -rf __pycache__

##################################################
### Python3 Host
##################################################

## Install development environment (python, pip, virtualenv)
dev-install:
ifeq (${SYSTEM}, Linux)
	@printf "${INFO}sudo apt-get update${NL}"
	@sudo apt-get update
	@printf "${INFO}sudo apt-get install -y python3${NL}"
	@sudo apt-get install -y python3
	@printf "${INFO}sudo apt-get install -y python3-pip${NL}"
	@sudo apt-get install -y python3-pip
	@printf "${INFO}pip3 install --upgrade pip${NL}"
	@pip3 install --upgrade pip
	@printf "${INFO}sudo apt-get install -y python-virtualenv${NL}"
	@sudo apt-get install -y python-virtualenv
endif

##################################################
### Check Python install
##################################################

## Check correct python environment installation
check-install:
	@if [ -n "$(shell pip --version 2>/dev/null)" ]; then \
		printf "${INFO}pip --version${NL}"; \
		pip --version; \
	else \
		printf "${WARNING}pip is not installed on your system${NL}"; \
	fi
	@if [ -n "$(shell pip3 --version 2>/dev/null)" ]; then \
		printf "${INFO}pip3 --version${NL}"; \
		pip3 --version; \
	else \
		printf "${WARNING}pip3 is not installed on your system${NL}"; \
	fi
	@if [ -n "$(shell python --version 2>/dev/null)" ]; then \
		printf "${INFO}python --version${NL}"; \
		python --version; \
	else \
		printf "${WARNING}python is not installed on your system${NL}"; \
	fi
	@if [ -n "$(shell python2 --version 2>/dev/null)" ]; then \
		printf "${INFO}python2 --version${NL}"; \
		python2 --version; \
	else \
		printf "${WARNING}python2 is not installed on your system${NL}"; \
	fi
	@if [ -n "$(shell python3 --version 2>/dev/null)" ]; then \
		printf "${INFO}python3 --version${NL}"; \
		python3 --version; \
	else \
		printf "${WARNING}python3 is not installed on your system${NL}"; \
	fi
	@if [ -n "$(shell virtualenv --version 2>/dev/null)" ]; then \
		printf "${INFO}virtualenv --version${NL}"; \
		virtualenv --version; \
	else \
		printf "${WARNING}virtualenv is not installed on your system${NL}"; \
	fi

