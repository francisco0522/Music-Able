# Music-able

This is our Portfolio Project, concluding our Foundations Year at Holberton School.

## Project Description

<p>This project is for the DJ to take into account the songs his audience likes and the communication between the audience and the DJ is better, with Music-able it can be easily accomplished to help the DJ to know what music they want to listen to. It also offers the public the possibility of choosing the songs they want to listen to right now with a vote or paying for it.</p>


## Data Modelling

![](https://github.com/JuanDavidDava2/Music_api/blob/master/images/data.PNG)

## Technologies

* MySQL
* Javascript
* Python
* Data API
* Spotify Web API
* Flutter

## API and methods

* /api/users
GET: Get all users.
POST: Create a new user.

* /api/users/<user_id>
GET: Get an user from id.
DELETE: Delete an user from id.
PUT: Update an old user.

* /api/places
GET: Returns the places where dj are with the same app.
POST: Create a new place.

* /api/places/<place_id>
GET: Returns the address of the place.
DELETE: Delete a place.
PUT: Update an old place.

* /api/DJs
GET: Returns the data of djs.
POST: Create a new dj.

* /api/DJs/<dj_id>
GET: Return the information from a specific dj.
DELETE: Delete a dj from id.
PUT: Update an old dj.

* /api/musicplaylist
GET: Gets all songs by id.
POST: Create a new list

* /api/musicplaylist/<musicplaylist_id>
GET: Gets a songs base form the id.
DELETE: Deletes songs base form the id.
PUT: Update a old songs.

* /api/musicplaylist/<musicplaylist_id>/songs
GET: Get all the songs on a playlist

* /api/musicplaylist/<musicplaylist_id>/songs/<songs_id>
DELETE: Delete songs
POST: Post new

## Mockups

![](https://github.com/JuanDavidDava2/Music_api/blob/master/images/Mockups.PNG)
![](https://github.com/JuanDavidDava2/Music_api/blob/master/images/Mockups2.PNG)


## License

Public Domain. No copy write protection.

## Authors
* Michelle Molina - [Github](https://github.com/michelalejo)
* Francisco Londoño - [Github](https://github.com/francisco0522)
* Juan Davalos - [Github](https://github.com/JuanDavidDava2)
