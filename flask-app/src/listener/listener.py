from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


listener = Blueprint('listener', __name__)

# Get all listeners from the DB
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

@listener.route('/addPlaylist', methods=['POST'])
def add_playlist():
    current_app.logger.info('Processing form data')
    req_data = request.get_json()
    current_app.logger.info(req_data)

    Name = str(req_data['Name'])
    Description = str(req_data['Description'])
    ListenerID = str(req_data['ListenerID'])
    SongID = str(req_data['ListenerID'])


    insert_stmt = 'INSERT INTO Playlists (Name, Description, ListenerID, SongID) VALUES ("'
    insert_stmt+= Name + '", "' + Description + '", ' + ListenerID + ',' + SongID + ')'

    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return "Success"

@listener.route('/addPlaylistSong', methods=['POST'])
def add_song_playlist():
    current_app.logger.info('Processing form data')
    req_data = request.get_json()
    current_app.logger.info(req_data)

    PlaylistID = str(req_data['PlaylistID'])
    Name = str(req_data['Name'])
    ListenerID = str(req_data['ListenerID'])
    SongID = str(req_data['SongID'])

    insert_stmt = 'INSERT INTO Playlists (PlaylistID, Name, Description, ListenerID, SongID) VALUES ('
    insert_stmt+= PlaylistID + ',"' + Name + '", " '  + '", ' + ListenerID + ',' + SongID + ')'

    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return "Success"

@listener.route('/removePlaylistSong/<PlaylistID>/<SongID>', methods=['DELETE'])
def delete_song_playlist(PlaylistID, SongID):

    insert_stmt = 'DELETE FROM Playlists WHERE PlaylistID = ' + PlaylistID + ' AND SongID = ' + SongID 

    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return "Success"


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


# update given ListenerID's subscription type to given SubscriptionTypeID
@listener.route('/listenerPlan/<ListenerID>/<SubscriptionTypeID>', methods=['PUT'])
def update_listener_plan(ListenerID, SubscriptionTypeID):
    cursor = db.get_db().cursor()
    cursor.execute('UPDATE Listener SET SubscriptionTypeID = {0} WHERE ListenerID = {1}'.format(SubscriptionTypeID, ListenerID))
    db.get_db().commit()

    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Listener WHERE ListenerID = {0}'.format(ListenerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# update given ListenerID's plays for a songid they listen to
@listener.route('/updatePlays/<ListenerID>/<SongID>', methods=['PUT'])
def update_number_plays(ListenerID, SongID):

    cursor = db.get_db().cursor()
    cursor.execute('select TimesPlayed from ListenerPlays where ListenerID = {0} and SongID = {1}'.format(ListenerID, SongID))
    theData = cursor.fetchall()

    if len(theData) > 0:
        num = theData[0][0] + 1

        cursor = db.get_db().cursor()
        cursor.execute('UPDATE ListenerPlays SET TimesPlayed = {0} WHERE ListenerID = {1} and SongID = {2}'.format(num, ListenerID, SongID))
    else:
        cursor = db.get_db().cursor()
        cursor.execute('INSERT INTO ListenerPlays  (ListenerID, SongID, TimesPlayed) VALUES ({0} , {1}, 1)'.format(ListenerID, SongID))
    
    db.get_db().commit()


    return "Success"
