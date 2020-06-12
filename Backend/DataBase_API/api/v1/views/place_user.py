#!/usr/bin/python3
""" Show, Delete, Create and Update users """
from api.v1.views import app_views
from flask import jsonify, request, abort, make_response
from models import storage
from models.user import User
from models.place import Place


@app_views.route('/places/<place_id>/users',
                 strict_slashes=False, methods=['GET'])
def get_place_user_id(place_id):
    """ Endpoint that handle http methods for a users
        place_id : is the id of the required place
    """
    place = storage.get(Place, place_id)
    if not place:
        abort(404)
    users = [place.to_dict() for place in place.users]
    return jsonify(users)


@app_views.route('/places/<place_id>/users/<users_id>',
                 strict_slashes=False, methods=['DELETE', 'POST'])
def users_by_place(place_id, users_id):
    """ Endpoint that handle http methods for users of a place
        place_id: Is the id of the required place"""
    place = storage.get(Place, place_id)
    users = storage.get(User, users_id)

    if not place:
        abort(404)

    if not users:
        abort(404)

    if request.method == 'DELETE':
        if users_id not in [a.id for a in place.users]:
            abort(404)
        place.users.remove(users)
        storage.save()
        return jsonify({}), 200

    if request.method == 'POST':
        if users_id in [a.id for a in place.users]:
            return jsonify(users.to_dict()), 200
        else:
            place.users.append(users)
            storage.save()
            return jsonify(users.to_dict()), 201
