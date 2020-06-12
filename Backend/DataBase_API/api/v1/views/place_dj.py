#!/usr/bin/python3
""" Show, Delete, Create and Update djs """
from api.v1.views import app_views
from flask import jsonify, request, abort, make_response
from models import storage
from models.dj import Dj
from models.place import Place


@app_views.route('/places/<place_id>/djs',
                 strict_slashes=False, methods=['GET'])
def get_place_dj_id(place_id):
    """ Endpoint that handle http methods for a djs
        place_id : is the id of the required place
    """
    place = storage.get(Place, place_id)
    if not place:
        abort(404)
    djs = [place.to_dict() for place in place.djs]
    return jsonify(djs)


@app_views.route('/places/<place_id>/djs/<djs_id>',
                 strict_slashes=False, methods=['DELETE', 'POST'])
def djs_by_place(place_id, djs_id):
    """ Endpoint that handle http methods for djs of a place
        place_id: Is the id of the required place"""
    place = storage.get(Place, place_id)
    djs = storage.get(Dj, djs_id)

    if not place:
        abort(404)

    if not djs:
        abort(404)

    if request.method == 'DELETE':
        if djs_id not in [a.id for a in place.djs]:
            abort(404)
        place.djs.remove(djs)
        storage.save()
        return jsonify({}), 200

    if request.method == 'POST':
        if djs_id in [a.id for a in place.djs]:
            return jsonify(djs.to_dict()), 200
        else:
            place.djs.append(djs)
            storage.save()
            return jsonify(djs.to_dict()), 201
