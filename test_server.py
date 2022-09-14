#!/usr/bin/env python3

from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/data", methods=["GET"])
def provide_data():
    return open("edible_campus_data.json", "r").read()


@app.route("/hash", methods=["GET"])
def get_hash():
    return jsonify({"hash": hash(open("edible_campus_data.json", "r").read())})


# TODO make this actually work
@app.route("/verify/<hsh>", methods=["GET"])
def check_hash(hsh):
    isCurrent = hash(open("edible_campus_data.json", "r")) == hsh
    return jsonify({"current": isCurrent})


# TODO add put/push/whatever function


if __name__ == "__main__":
    app.run(debug=True)
