#!/usr/bin/python
""" holds class Amenity"""
import models
from models.base_model import BaseModel, Base
from os import getenv
import sqlalchemy
from sqlalchemy import Column, String, Integer, Float, ForeignKey, Table, VARCHAR
from sqlalchemy.orm import relationship


if models.storage_t == 'db':
    musicplaylist_songs = Table('musicplaylist_songs', Base.metadata,
                          Column('Musicplaylist_id', String(60),
                                 ForeignKey('musicplaylists.id', onupdate='CASCADE',
                                            ondelete='CASCADE'),
                                 primary_key=True),
                          Column('song_id', String(60),
                                 ForeignKey('Song.id', onupdate='CASCADE',
                                            ondelete='CASCADE'),
                                 primary_key=True))

class Musicplaylist(BaseModel, Base):
    """Representation of Musicplaylist """
    if models.storage_t == 'db':
        __tablename__ = 'musicplaylists'
        name = Column(String(128), nullable=False)
        songs = relationship("Song",
                                 secondary=musicplaylist_songs,
                                 viewonly=False)
    

    else:
        name = ""

    def __init__(self, *args, **kwargs):
        """initializes Musicplaylist"""
        super().__init__(*args, **kwargs)