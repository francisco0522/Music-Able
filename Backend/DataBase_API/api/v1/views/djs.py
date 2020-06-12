#!/usr/bin/python3
"""Instance of Flask"""


from flask import Flask, jsonify, request, abort
from models import storage, dj
from api.v1.views import app_views
from models.dj import Dj


@app_views.route('/djs', methods=['GET'],
                 strict_slashes=False)
def get_djs():
    """Gets all dj by id"""
    new_dict = []
    for data in storage.all("Dj").values():
        new_dict.append(data.to_dict())
    return jsonify(new_dict)


@app_views.route('/djs/<dj_id>', methods=['GET'],
                 strict_slashes=False)
def get_dj_by_id(dj_id=None):
    """Gets a dj base form the id."""
    data_id = storage.get("Dj", dj_id)
    if data_id is None:
        abort(404)
    else:
        return jsonify(data_id.to_dict())


@app_views.route('/djs/<dj_id>', methods=['DELETE'],
                 strict_slashes=False)
def delete_dj_by_id(dj_id=None):
    """Deletes a dj base form the id."""
    data_id = storage.get("Dj", dj_id)
    if data_id is None:
        abort(404)
    else:
        storage.delete(data_id)
        storage.save()
        return jsonify({}), 200


@app_views.route('/djs', methods=['POST'],
                 strict_slashes=False)
def create_a_dj():
    """ Create a new dj."""
    is_json = request.get_json(silent=True)
    if is_json is None:
        abort(400, "Not a JSON")
    if 'email' not in is_json:
        abort(400, 'Missing email')
    if 'password' not in is_json:
        abort(400, 'Missing password')
    new_dj = Dj(**is_json)
    new_dj.save()
    return jsonify(new_dj.to_dict()), 201


@app_views.route('/djs/<dj_id>', methods=['PUT'],
                 strict_slashes=False)
def put_a_dj(dj_id):
    """ Update a old dj."""
    first_dj = storage.get("Dj", dj_id)
    if first_dj is None:
        abort(404)
    is_json = request.get_json()
    if is_json is None:
        abort(400, "Not a JSON")
    dont = ['id', 'email', 'created_at', 'updated_at']
    for key, value in is_json.items():
        if key in dont:
            pass
        else:
            setattr(first_dj, key, value)
    first_dj.save()
    return jsonify(first_dj.to_dict()), 200
