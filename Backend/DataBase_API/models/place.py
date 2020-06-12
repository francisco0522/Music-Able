#!/usr/bin/python
""" holds class Place"""
import models
from models.base_model import BaseModel, Base
from os import getenv
import sqlalchemy
from sqlalchemy import Column, String, Integer, Float, ForeignKey, Table, VARCHAR
from sqlalchemy.orm import relationship


if models.storage_t == 'db':
    place_Musicplaylist = Table('place_Musicplaylist', Base.metadata,
                          Column('place_id', String(60),
                                 ForeignKey('places.id', onupdate='CASCADE',
                                            ondelete='CASCADE'),
                                 primary_key=True),
                          Column('Musicplaylist_id', String(60),
                                 ForeignKey('musicplaylists.id', onupdate='CASCADE',
                                            ondelete='CASCADE'),
                                 primary_key=True))

    place_users = Table('place_users', Base.metadata,
                          Column('place_id', String(60),
                                 ForeignKey('places.id', onupdate='CASCADE',
                                            ondelete='CASCADE'),
                                 primary_key=True),
                          Column('user_id', String(60),
                                 ForeignKey('users.id', onupdate='CASCADE',
                                            ondelete='CASCADE'),
                                 primary_key=True))

    place_djs = Table('place_djs', Base.metadata,
                          Column('place_id', String(60),
                                 ForeignKey('places.id', onupdate='CASCADE',
                                            ondelete='CASCADE'),
                                 primary_key=True),
                          Column('dj_id', String(60),
                                 ForeignKey('djs.id', onupdate='CASCADE',
                                            ondelete='CASCADE'),
                                 primary_key=True))
    
class Place(BaseModel, Base):
    """Representation of Place """
    if models.storage_t == 'db':
        __tablename__ = 'places'
        pname = Column(String(128), nullable=False)
        club_img = Column(String(1280), nullable=False)
        pstreet = Column(VARCHAR(128), nullable=False, default=0)
        pzipcode = Column(Integer, nullable=True, default=0)
        musicplaylist = relationship("Musicplaylist",
                                 secondary=place_Musicplaylist,
                                 viewonly=False)
        users = relationship("User",
                                 secondary=place_users,
                                 viewonly=False)
        djs = relationship("Dj",
                                 secondary=place_djs,
                                 viewonly=False)

    else:
        user_id = ""
        dj_id = ""
        pname = ""
        pstreet = 0
        pzipcode = 0

    def __init__(self, *args, **kwargs):
        """initializes Place"""
        super().__init__(*args, **kwargs)
