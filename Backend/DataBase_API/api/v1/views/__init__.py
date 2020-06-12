#!/usr/bin/python3
"""Instance of Flask"""


from flask import Blueprint
app_views = Blueprint('api', __name__, url_prefix='/api/v1')
from api.v1.views.index import *
from api.v1.views.users import *
from api.v1.views.djs import *
from api.v1.views.places import *
from api.v1.views.Musicplaylist import *
from api.v1.views.place_Musicplaylist import *
from api.v1.views.place_user import *
from api.v1.views.place_dj import *
from api.v1.views.Song import *
from api.v1.views.musicplaylist_song import *
