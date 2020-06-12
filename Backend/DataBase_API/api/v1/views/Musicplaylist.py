#!/usr/bin/python3
"""Instance of Flask"""


from flask import Flask, jsonify, request, abort
from models import storage, Musicplaylist
from api.v1.views import app_views
from models.Musicplaylist import Musicplaylist


#done
@app_views.route('/musicplaylist', methods=['GET'],
                 strict_slashes=False)
def get_amenity_by_id():
    """Gets all amenity by id"""
    new_dict = []
    for data in storage.all("Musicplaylist").values():
        new_dict.append(data.to_dict())
    return jsonify(new_dict)

# done
@app_views.route('/musicplaylist/<musicplaylist_id>', methods=['GET'],
                 strict_slashes=False)
def get_Amenity_by_id(musicplaylist_id=None):
    """Gets a Amenity base form the id."""
    data_id = storage.get("Musicplaylist", musicplaylist_id)
    if data_id is None:
        abort(404)
    else:
        return jsonify(data_id.to_dict())

#done
@app_views.route('/musicplaylist/<musicplaylist_id>', methods=['DELETE'],
                 strict_slashes=False)
def delete_Amenity_by_id(musicplaylist_id=None):
    """Deletes a Amenity base form the id."""
    data_id = storage.get("Musicplaylist", musicplaylist_id)
    if data_id is None:
        abort(404)
    else:
        storage.delete(data_id)
        storage.save()
        return jsonify({}), 200

# done
@app_views.route('/musicplaylist', methods=['POST'], strict_slashes=False)
def create_a_Amenity():
    """ Create a new Amenity."""
    data = request.get_json()
    if not data:
        abort(400, 'Not a JSON')
    if "name" not in data:
        abort(400, 'Missing name')
    new_place = Musicplaylist(**data)
    new_place.save()
    storage.save()
    return jsonify(new_place.to_dict()), 201

# done
@app_views.route('/musicplaylist/<musicplaylist_id>', methods=['PUT'],
                 strict_slashes=False)
def put_a_Amenity(musicplaylist_id):
    """ Update a old Amenity."""
    first_Amenity = storage.get("Musicplaylist", musicplaylist_id)
    if first_Amenity is None:
        abort(404)
    is_json = request.get_json()
    if is_json is None:
        abort(400, "Not a JSON")
    dont = ['id', 'created_at', 'updated_at']
    for key, value in is_json.items():
        if key in dont:
            pass
        else:
            setattr(first_Amenity, key, value)
    storage.save()
    return jsonify(first_Amenity.to_dict()), 200
