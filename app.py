#!/usr/bin/env python3
import sys
import bottle
from beaker.middleware import SessionMiddleware
import json

session_opts = {
    "session.type": "file",
    "session.cookie_expires": 300,
    "session.data_dir": "./data",
    "session.auto": True
}
app = SessionMiddleware(bottle.app(), session_opts)

with open("products.json") as f:
    products = json.load(f)["product"]


@bottle.route("/")
def index():
    # TODO: Implement session
    return bottle.template("index", products=products)


@bottle.route("/static/<filename:path>")
def static_file(filename):
    return bottle.static_file(filename, root="static")


@bottle.error(404)
def error404(error):
    return "<h1>Error 404: Page not found.</h1>"


bottle.run(app=app, host="0.0.0.0", port=sys.argv[1], debug=True, reloader=True)
