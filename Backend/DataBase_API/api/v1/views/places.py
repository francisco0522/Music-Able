#!/usr/bin/python3
"""Instance of Flask"""


from flask import Flask, jsonify, request, abort
from models import storage
from api.v1.views import app_views
from models.place import Place
from models.base_model import BaseModel


@app_views.route('/cities/<city_id>/places', methods=['GET'],
                 strict_slashes=False)
def get_places_city(city_id):
    """Gets all places of a city."""
    data = storage.get("City", city_id)
    if data is None:
        abort(404)
    new_dict = []
    for data in data.places:
        new_dict.append(data.to_dict())
    return jsonify(new_dict)

#done
@app_views.route('/places/', methods=['GET'],
                 strict_slashes=False)
def get_places():
    """Gets all places by id"""
    new_dict = []
    for data in storage.all("Place").values():
        new_dict.append(data.to_dict())
    return jsonify(new_dict)

#done
@app_views.route('/places/<place_id>', methods=['GET'],
                 strict_slashes=False)
def get_places_by_id(place_id):
    """Gets a places base form the id."""
    data_id = storage.get("Place", place_id)
    if data_id is None:
        abort(404)
    else:
        return jsonify(data_id.to_dict())

#done
@app_views.route('/places/<place_id>', methods=['DELETE'],
                 strict_slashes=False)
def delete_places_by_id(place_id):
    """Deletes a places base form the id."""
    data_id = storage.get(Place, place_id)
    if data_id is None:
        abort(404)
    storage.delete(data_id)
    storage.save()
    return jsonify({}), 200

# done
@app_views.route('/places', methods=['POST'],
                 strict_slashes=False)
def create_a_places():
    """ Create a new places."""
    data = request.get_json()
    if not data:
        abort(400, 'Not a JSON')
    if "pname" not in data:
        abort(400, 'Missing pname')
    if "pstreet" not in data:
        abort(400, 'Missing pstreet')
    if "pzipcode" not in data:
        abort(400, 'Missing pzipcode')
    new_place = Place(**data)
    new_place.save()
    storage.save()
    return jsonify(new_place.to_dict()), 201

#done
@app_views.route('/places/<place_id>', methods=['PUT'], strict_slashes=False)
def put_a_places(place_id):
    """ Update a old places."""
    first_place = storage.get("Place", place_id)
    if first_place is None:
        abort(404)
    is_json = request.get_json()
    if is_json is None:
        abort(400, "Not a JSON")
    dont = ['id', 'created_at', 'updated_at']
    for key, value in is_json.items():
        if key in dont:
            pass
        else:
            setattr(first_place, key, value)
    first_place.save()
    return jsonify(first_place.to_dict()), 200
