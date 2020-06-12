#!/usr/bin/python3.6
""" Test link Many-To-Many Place <> Amenity
"""
from models import *
from models.user import User
from models.place import Place
from models.dj import Dj
from models.Musicplaylist import Musicplaylist
from models.Song import Song

# creation of a User
user = User(email="john@snow.com", passwd="johnpwd", full_name="Michel Molina")
user.save()

# creation of a Dj
djs = Dj(email="john@snow.com", passwd="johnpwd", full_name="Michel Molina", )
djs.save()

# creation of 2 Places
place_1 = Place(pname="Casa Michel", pstreet="cra 124 # 18 - 100", pzipcode="760008", club_img="https://d3jv0cqma81l17.cloudfront.net/sites/416/images/original/restaurante-bar-discoteca-la-pergola-clandestina-52.jpg?1538509372")
place_1.save()

song_1 = Song(songname="puto", songnamelink="https://open.spotify.com/album/7h9NpO38NZFD8vcEHw4lkZ", songartists="Molotov", songgenre="Alternativa")

Musicplaylist_1 = Musicplaylist(name=f"{djs.full_name} list {place_1.pname}")
Musicplaylist_1.save()

Musicplaylist_1.songs.append(song_1)

place_1.musicplaylist.append(Musicplaylist_1)

place_1.users.append(user)
place_1.djs.append(djs)


storage.save()

print("OK")
