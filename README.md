TangoMan Flask Boilerplate
==========================

Awesome **TangoMan Flask Boilerplate** is a fast and handy tool to manage your Flask application with virtualenv easily

Features
--------

**TangoMan Flask Boilerplate** provides the following features:

- Install Python
- Deploy Flask app locally
- Deploy Flask app in Virtualenv

Installation
------------

### Just enter following command

```bash
$ make up
```

Dependencies
------------

**TangoMan Flask Boilerplate** requires the following dependencies:

- Make

### Make

#### Install Make (Linux)

On linux machine enter following command

```bash
$ sudo apt-get install -y make
```

#### Install Make (Windows)

On windows machine you will need to install [cygwin](http://www.cygwin.com/) or [GnuWin make](http://gnuwin32.sourceforge.net/packages/make.htm) first to execute make script.

Usage
-----

Run `make` to print help

```bash
$ make [command] filename=[filename] port=[port] virtualenv=[virtualenv] 
```

Valid commands are: help install run freeze dev-install check-install up serve stop venv-run venv-create venv-start venv-stop venv-install venv-remove venv-up venv-serve venv-kill 

Commands
--------

#### help
```
$ make help
```
Print this help

### Python3 CLI
#### install
```
$ make install
```
Install

#### run
```
$ make run
```
Start app

#### freeze
```
$ make freeze
```
Generate requirements.txt

### Python3 Host
#### dev-install
```
$ make dev-install
```
Install development environment (python, pip, virtualenv)

### Check Python install
#### check-install
```
$ make check-install
```
Check correct python environment installation

### Python Flask
#### up
```
$ make up
```
Deploy and start Flask app locally with one command

#### serve
```
$ make serve
```
Open default browser Serve app with gunicorn at localhost

#### stop
```
$ make stop
```
Kill gunicorn server

### Python Virtualenv
#### venv-run
```
$ make venv-run
```
Start

#### venv-create
```
$ make venv-create
```
Create virtualenv

#### venv-start
```
$ make venv-start
```
Activate virtualenv

#### venv-stop
```
$ make venv-stop
```
Deactivate virtualenv

#### venv-install
```
$ make venv-install
```
Install in virtualenv

#### venv-remove
```
$ make venv-remove
```
Remove virtualenv

### Python Virtualenv Flask
#### venv-up
```
$ make venv-up
```
Deploy and start your Flask app in fresh virtualenv with one command

#### venv-serve
```
$ make venv-serve
```
Serve app with gunicorn from virtualenv

#### venv-kill
```
$ make venv-kill
```
Kill gunicorn server and remove virtualenv

License
-------

Copyrights (c) 2020 &quot;Matthias Morin&quot; &lt;mat@tangoman.io&gt;

[![License](https://img.shields.io/badge/Licence-MIT-green.svg)](LICENCE)
Distributed under the MIT license.

If you like **TangoMan Flask Boilerplate** please star, follow or tweet:

[![GitHub stars](https://img.shields.io/github/stars/TangoMan75/flask-boilerplate?style=social)](https://github.com/TangoMan75/flask-boilerplate/stargazers)
[![GitHub followers](https://img.shields.io/github/followers/TangoMan75?style=social)](https://github.com/TangoMan75)
[![Twitter](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Fgithub.com%2FTangoMan75%2Fflask-boilerplate)](https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2FTangoMan75%2Fflask-boilerplate)

... And check my other cool projects.

[![LinkedIn](https://img.shields.io/static/v1?style=social&logo=linkedin&label=LinkedIn&message=morinmatthias)](https://www.linkedin.com/in/morinmatthias)
