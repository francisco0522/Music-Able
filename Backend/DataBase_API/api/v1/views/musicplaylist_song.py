#!/usr/bin/python3
""" Show, Delete, Create and Update songs """
from api.v1.views import app_views
from flask import jsonify, request, abort, make_response
from models import storage
from models.Song import Song
from models.Musicplaylist import Musicplaylist


@app_views.route('/musicplaylist/<musicplaylist_id>/songs',
                 strict_slashes=False, methods=['GET'])
def get_musicplaylist_song_id(musicplaylist_id):
    """ Endpoint that handle http methods for a songs
        musicplaylist_id : is the id of the required musicplaylist
    """
    musicplaylist = storage.get(Musicplaylist, musicplaylist_id)
    if not musicplaylist:
        abort(404)
    songs = [musicplaylist.to_dict() for musicplaylist in musicplaylist.songs]
    return jsonify(songs)


@app_views.route('/musicplaylist/<musicplaylist_id>/songs/<songs_id>',
                 strict_slashes=False, methods=['DELETE', 'POST'])
def songs_by_musicplaylist(musicplaylist_id, songs_id):
    """ Endpoint that handle http methods for songs of a musicplaylist
        musicplaylist_id: Is the id of the required musicplaylist"""
    musicplaylist = storage.get(Musicplaylist, musicplaylist_id)
    songs = storage.get(Song, songs_id)
    if not musicplaylist:
        abort(404)
    if not songs:
        abort(404)
    if request.method == 'DELETE':
        if songs_id not in [a.id for a in musicplaylist.songs]:
            abort(404)
        musicplaylist.songs.remove(songs)
        storage.save()
        return jsonify({}), 200

    if request.method == 'POST':
        if songs_id in [a.id for a in musicplaylist.songs]:
            return jsonify(songs.to_dict()), 200
        else:
            musicplaylist.songs.append(songs)
            storage.save()
            return jsonify(songs.to_dict()), 201
