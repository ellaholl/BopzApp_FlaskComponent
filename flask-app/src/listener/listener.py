from flask import Blueprint, request, jsonify, make_response
import json
from src import db


listener = Blueprint('listener', __name__)

# Get all customers from the DB
@listener.route('/listener', methods=['GET'])
def get_listeners():
    cursor = db.get_db().cursor()
    cursor.execute('select username, ListenerID from Listener')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get customer detail for customer with particular userID
@listener.route('/listener/<ListenerID>', methods=['GET'])
def get_listener_info(ListenerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Listener where ListenerID = {0}'.format(ListenerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@listener.route('/listenerPlaylist/<ListenerID>/', methods=['GET'])
def get_listener_playlist(ListenerID):
    cursor = db.get_db().cursor()
    cursor.execute('select Playlists.Name, Playlists.Description, Playlists.PlaylistID from Listener natural join Playlists where ListenerID = {0}'.format(ListenerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@listener.route('/playlistSongs/<PlaylistID>', methods=['GET'])
def get_playlist_song(PlaylistID):
    cursor = db.get_db().cursor()
    cursor.execute('select Title, SongID, Length from Song natural join Playlists where PlaylistID = {0}'.format(PlaylistID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get customer detail for customer with particular userID
@listener.route('/listenerPlan/<ListenerID>', methods=['GET'])
def get_listener_plan(ListenerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from SubscriptionType natural join Listener where ListenerID = {0}'.format(ListenerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all customers from the DB
@listener.route('/listenerPlan/', methods=['GET'])
def get_plans():
    cursor = db.get_db().cursor()
    cursor.execute('select distinct(Name), SubscriptionTypeID from SubscriptionType')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response