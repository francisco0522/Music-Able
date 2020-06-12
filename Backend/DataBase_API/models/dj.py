#!/usr/bin/python3
""" holds class dj"""

import models
from models.base_model import BaseModel, Base
from os import getenv
import sqlalchemy
from sqlalchemy import Column, String
from sqlalchemy.orm import relationship
from hashlib import md5


class Dj(BaseModel, Base):
    """Representation of a dj """
    if models.storage_t == 'db':
        __tablename__ = 'djs'
        email = Column(String(128), nullable=False)
        passwd = Column(String(128), nullable=False)
        full_name = Column(String(128), nullable=False)
    else:
        email = ""
        passwd = ""
        full_name = ""


    def __init__(self, *args, **kwargs):
        """initializes dj"""
        super().__init__(*args, **kwargs)
