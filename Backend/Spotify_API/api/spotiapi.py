#!/usr/bin/python3
from flask import Flask, render_template, jsonify
from flask import request, redirect, session
from os import environ
import uuid
from models.Client_token import SpotifyAPI
from pprint import pprint


client_id = '69160eb22cf244e68ce329125c74ead4'
client_secret = '68916bd8bf8f4376917b7b4668bc6373'

app = Flask(__name__)

@app.route('/home', strict_slashes=False)
def home():
    """Home page"""
    code = request.args.get("code")
    spotify = SpotifyAPI(client_id, client_secret)
    asd = spotify.search({"track": f"{code}"}, search_type="track")
    for k, v in asd["tracks"]["items"][0].items():
        pprint(v)
    return jsonify(asd)


if (__name__ == "__main__"):
    app.run(host='0.0.0.0', port=5000, debug=True)
