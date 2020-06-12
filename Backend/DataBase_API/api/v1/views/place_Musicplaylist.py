#!/usr/bin/python3
""" Show, Delete, Create and Update musicplaylist """
from api.v1.views import app_views
from flask import jsonify, request, abort, make_response
from models import storage
from models.Musicplaylist import Musicplaylist
from models.place import Place


@app_views.route('/places/<place_id>/musicplaylists',
                 strict_slashes=False, methods=['GET'])
def get_place_musicplaylist_id(place_id):
    """ Endpoint that handle http methods for a musicplaylist
        place_id : is the id of the required place
    """
    place = storage.get(Place, place_id)
    if not place:
        abort(404)
    musicplaylist = [place.to_dict() for place in place.musicplaylist]
    return jsonify(musicplaylist)


@app_views.route('/places/<place_id>/musicplaylists/<musicplaylist_id>',
                 strict_slashes=False, methods=['DELETE', 'POST'])
def musicplaylist_by_place(place_id, musicplaylist_id):
    """ Endpoint that handle http methods for musicplaylist of a place
        place_id: Is the id of the required place"""
    place = storage.get(Place, place_id)
    musicplaylist = storage.get(Musicplaylist, musicplaylist_id)

    if not place:
        abort(404)

    if not musicplaylist:
        abort(404)

    if request.method == 'DELETE':
        if musicplaylist_id not in [a.id for a in place.musicplaylist]:
            abort(404)
        place.musicplaylist.remove(musicplaylist)
        storage.save()
        return jsonify({}), 200

    if request.method == 'POST':
        if musicplaylist_id in [a.id for a in place.musicplaylist]:
            return jsonify(musicplaylist.to_dict()), 200
        else:
            place.musicplaylist.append(musicplaylist)
            storage.save()
            return jsonify(musicplaylist.to_dict()), 201
