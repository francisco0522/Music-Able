#!/usr/bin/python3
"""Instance of Flask"""


from flask import Flask, jsonify, request, abort
from models import storage, Song
from api.v1.views import app_views
from models.Song import Song


#done
@app_views.route('/songs', methods=['GET'],
                 strict_slashes=False)
def get_song_by_id():
    """Gets all song by id"""
    new_dict = []
    for data in storage.all("Song").values():
        new_dict.append(data.to_dict())
    return jsonify(new_dict)

# done
@app_views.route('/songs/<songs_id>', methods=['GET'],
                 strict_slashes=False)
def get_Song_by_id(songs_id=None):
    """Gets a Song base form the id."""
    data_id = storage.get("Song", songs_id)
    if data_id is None:
        abort(404)
    else:
        return jsonify(data_id.to_dict())

#done
@app_views.route('/songs/<songs_id>', methods=['DELETE'],
                 strict_slashes=False)
def delete_Song_by_id(songs_id=None):
    """Deletes a Song base form the id."""
    data_id = storage.get("Song", songs_id)
    if data_id is None:
        abort(404)
    else:
        storage.delete(data_id)
        storage.save()
        return jsonify({}), 200

# done
@app_views.route('/songs', methods=['POST'], strict_slashes=False)
def create_a_Song():
    """ Create a new Song."""
    data = request.get_json()
    if not data:
        abort(400, 'Not a JSON')
    if "songname" not in data:
        abort(400, 'Missing songname')
    if "songnamelink" not in data:
        abort(400, 'Missing songnamelink')
    if "songartists" not in data:
        abort(400, 'Missing songartists')
    if "songgenre" not in data:
        abort(400, 'Missing songgenre')
    new_place = Song(**data)
    new_place.save()
    storage.save()
    return jsonify(new_place.to_dict()), 201

# done
@app_views.route('/songs/<songs_id>', methods=['PUT'],
                 strict_slashes=False)
def put_a_Song(songs_id):
    """ Update a old Song."""
    first_Song = storage.get("Song", songs_id)
    if first_Song is None:
        abort(404)
    is_json = request.get_json()
    if is_json is None:
        abort(400, "Not a JSON")
    dont = ['id', 'created_at', 'updated_at']
    for key, value in is_json.items():
        if key in dont:
            pass
        else:
            setattr(first_Song, key, value)
    storage.save()
    return jsonify(first_Song.to_dict()), 200
