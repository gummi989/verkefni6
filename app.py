#!/usr/bin/env python3
import sys
import bottle
from beaker.middleware import SessionMiddleware
import json


def create_cart(session):

    if session.get("cart") is None:

        session["cart"] = []

        session.save()

session_opts = {
    "session.type": "file",
    "session.cookie_expires": 300,
    "session.data_dir": "./data",
    "session.auto": True
}
app = SessionMiddleware(bottle.app(), session_opts)

with open("products.json") as f:
    products = json.load(f)["product"]
    products = dict((product["id"], product) for product in products)


@bottle.route("/")
def index():
    s = bottle.request.environ.get("beaker.session")

    create_cart(s)  # Create cart if it does not exist

    return bottle.template("index", products=products, cart=s.get("cart"))

@bottle.route("/cart")

def cart():

    s = bottle.request.environ.get("beaker.session")

    create_cart(s)

    return bottle.template("cart", products=products, cart=s.get("cart"))





@bottle.get("/cart/add")

def add_to_cart():

    s = bottle.request.environ.get("beaker.session")

    pid = bottle.request.query.pid

    try:

        pid = int(pid)

    except ValueError:

        pid = None

    # product = next((p for p in products if p["id"] == pid), None)

    # If product exists, add it to cart

    if products.get(pid) is not None:

        create_cart(s)  # If cart does not exist, create it

        s["cart"].append(pid)

        s.save()

    bottle.redirect("/cart")





@bottle.route("/cart/remove")

def remove_from_cart():

    s = bottle.request.environ.get("beaker.session")

    pid = bottle.request.query.pid

    try:

        pid = int(pid)

    except ValueError:

        pid = None

    if pid is not None:

        create_cart(s)  # If cart does not exist, create it

        s["cart"] = [p for p in s.get("cart") if p != pid]

        s.save()

    bottle.redirect("/cart")





@bottle.route("/cart/empty")

def empty_cart():

    s = bottle.request.environ.get("beaker.session")

    s["cart"] = []

    s.save()

    bottle.redirect("/cart")

@bottle.route("/static/<filename:path>")
def static_file(filename):
    return bottle.static_file(filename, root="static")


@bottle.error(404)
def error404(error):
    return "<h1>Error 404: Page not found.</h1>"


bottle.run(app=app, host="0.0.0.0", port=sys.argv[1], debug=True, reloader=True)
