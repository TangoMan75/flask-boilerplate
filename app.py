#!/bin/python
# -*- coding: utf-8 -*-

from flask import Flask, request, jsonify, json
import os
import time
import logging

app = Flask(__name__)

logging.basicConfig(
    format='[%(asctime)s] %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S',
    level=logging.DEBUG
)

# @app.route('/')
# def api_index():
#     return f"Hello, try this route: /hello?name=tangoman"

# @app.route('/hello')
# def api_hello():
#     env = os.environ.get('env', 'prod')
#     name = request.args.get('name', 'John Doe')
#     return f"Hello {name} from '{env}'"

@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def catch_all(path):
    data = {
        'host': request.headers.get('Host'),
        'ip': request.remote_addr,
        'params': request.args,
        'path': path,
        'referer': request.headers.get('Referer'),
        'time': time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()),
        'user-agent': request.headers.get('User-Agent'),
    }
    app.logger.debug(json.dumps(data))
    return jsonify(data)

@app.before_request
def log_request_info():
    app.logger.info(' %s', request.headers)

# @app.errorhandler(404)
# def page_not_found(error):
#     # app.logger.info(' %s', request.headers.get('User-Agent'))
#     # app.logger.info(' %s', request.headers.get('Referer'))
#     # app.logger.info(' %s', request.headers)
#     # app.logger.info('Body: %s', request.get_data())
#     return f"Page Not Found"

if __name__ == '__main__':
    app.run()
