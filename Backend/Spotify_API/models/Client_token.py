#!/usr/bin/python3

import base64
import requests
import datetime
import json
from urllib.parse import urlencode
from pprint import pprint

client_id = '69160eb22cf244e68ce329125c74ead4'
client_secret = '68916bd8bf8f4376917b7b4668bc6373'

class SpotifyAPI(object):
    access_token = None
    access_token_expires =  datetime.datetime.now()
    access_token_did_expires = True
    client_id = None
    client_secret = None
    token_url = 'https://accounts.spotify.com/api/token'

    def __init__(self, client_id, client_secret, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.client_id = client_id
        self.client_secret = client_secret

    def get_client_credentials(self):
        """ Base64 encode credential string"""
        client_id = self.client_id
        client_secret = self.client_secret
        if client_id == None or client_secret == None:
            raise Exception("Please set client_id and client_secret")
        client_creds = f"{client_id}:{client_secret}"
        client_creds_base64 = base64.b64encode(client_creds.encode())
        return client_creds_base64.decode()

    def get_token_data(self):
        return {
            "grant_type": "client_credentials",
        }

    def get_token_header(self):
        client_creds_b64 = self.get_client_credentials()
        return {
            "Authorization": f"Basic {client_creds_b64}"
        }
        

    def perform_auth(self):
        """Create token and make comprobation to see if it expires"""
        token_url = self.token_url
        token_data = self.get_token_data()
        token_header = self.get_token_header()
        r = requests.post(token_url, data=token_data, headers=token_header)
        if r.status_code not in range(200, 299):
            raise Exception("Could not authenticate client.")
            # return False
        data = r.json()
        now = datetime.datetime.now()
        self.access_token = data['access_token']
        expires_in = data['expires_in']
        self.access_token_expires = now + datetime.timedelta(seconds=expires_in)
        self.access_token_did_expires = self.access_token_expires < now
        return True

    def get_resource_header(self):
        access_token = self.get_access_token()
        header = {
            "Authorization": f"Bearer {access_token}"
        }
        return header

    def get_resource(self, lookup_id, resource_type='albums', version='v1'):
        endpoint = f"https://api.spotify.com/{version}/{resource_type}/{lookup_id}"
        headers = self.get_resource_header()
        r = requests.get(endpoint, headers=headers)
        if r.status_code not in range(200, 299):
            return {}
        return r.json()

    def get_album(self, _id):
        return self.get_resource(_id, resource_type='albums')
    
    def get_artist(self, _id):
        return self.get_resource(_id, resource_type='artists')
            
    def get_access_token(self):
        token = self.access_token
        expires = self.access_token_expires
        now = datetime.datetime.now()
        if expires < now:
            self.perform_auth()
            return self.get_access_token()
        elif token == None:
            self.perform_auth()
            return self.get_access_token()
        return token


    def base_search(self, query_params):
        header = self.get_resource_header()
        search_url = "https://api.spotify.com/v1/search"
        endpoint = f"{search_url}?{query_params}"
        r = requests.get(endpoint, headers=header)
        if r.status_code not in range(200, 299):
            return {}
        return r.json()
    
    def search(self, query=None, search_type='track'):
        if query is None:
            raise Exception("query missing")
        if isinstance(query, dict):
            tmp = [f"{k}:{v}" for k, v in query.items()]
            query = " ".join(tmp)
        query_params = urlencode({
            "q": query,
            "type": search_type.lower()
        })
        print(query_params)
        return self.base_search(query_params)
