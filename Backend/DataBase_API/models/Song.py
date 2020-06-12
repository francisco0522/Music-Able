#!/usr/bin/python
""" holds class Amenity"""
import models
from models.base_model import BaseModel, Base
from os import getenv
import sqlalchemy
from sqlalchemy import Column, String, Integer, Float, ForeignKey, Table, VARCHAR
from sqlalchemy.orm import relationship



class Song(BaseModel, Base):
    """Representation of Musicplaylist """
    if models.storage_t == 'db':
        __tablename__ = 'Song'
        songname = Column(String(128), nullable=False)
        songnamelink = Column(String(128), nullable=False)
        songartists = Column(String(128), nullable=False)
        songgenre = Column(String(128), nullable=False)
    

    else:
        name = ""

    def __init__(self, *args, **kwargs):
        """initializes Musicplaylist"""
        super().__init__(*args, **kwargs)