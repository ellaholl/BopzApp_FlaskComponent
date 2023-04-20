from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


artist = Blueprint('artist', __name__)

@artist.route('/artist', methods=['GET'])
def get_artists():
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    cursor.execute('select CONCAT(FirstName, LastName) as Name, ArtistID from Artist')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


@artist.route('/artist/<ArtistID>', methods=['GET'])
def get_artist(ArtistID):
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    cursor.execute('select * from Artist where ArtistID = {0}'.format(ArtistID))

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

@artist.route('/ArtistSongs/<ArtistID>', methods=['GET'])
def get_artist_songs(ArtistID):
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    cursor.execute('select SongID, Title from Song natural join Artist where ArtistID = {0}'.format(ArtistID))

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

@artist.route('/artistPlan/<ArtistID>', methods=['GET'])
def get_artist_plan(ArtistID):
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    
    cursor.execute('select * from ArtistPlans natural join Artist where ArtistID = {0}'.format(ArtistID))

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

#update given ListenerID's subscription type to given SubscriptionTypeID
@artist.route('/addSong', methods=['POST'])
def add_song():
    current_app.logger.info('Processing form data')
    req_data = request.get_json()
    current_app.logger.info(req_data)

    Title = str(req_data['Title'])
    Length = str(req_data['Length'])
    ArtistID = str(req_data['ArtistID'])
    AlbumID = str(req_data['AlbumID'])
    GenreID = str(req_data['GenreID'])

    insert_stmt = 'INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID) VALUES ("'
    insert_stmt+= Title + '", ' + Length + ', ' + ArtistID + ', ' + AlbumID + ', ' + GenreID + ')'

    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return "Success"


# update given ListenerID's subscription type to given SubscriptionTypeID
@artist.route('/removeSong/<SongID>', methods=['DELETE'])
def remove_song(SongID):
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    cursor.execute('DELETE FROM Song WHERE SongID = {0}'.format(SongID))
    db.get_db().commit()

    return "Success"


@artist.route('/SongStats/<ArtistID>', methods=['GET'])
def get_song_stats(ArtistID):
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    cursor.execute('SELECT Song.Title, Song.ArtistID, SUM(ListenerPlays.TimesPlayed) from ListenerPlays natural join Song GROUP BY Song.Title, Song.SongID HAVING Song.ArtistID = {0}'.format(ArtistID))

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


@artist.route('/artistAlbums/<ArtistID>', methods=['GET'])
def get_artist_albums(ArtistID):
    cursor = db.get_db().cursor()

    cursor.execute('select albumID, album_name from Album natural join Artist where ArtistID = {0}'.format(ArtistID))

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


# update given ArtistID's plan to given ArtistPlanID
@artist.route('/artistPlan/<ArtistID>/<ArtistPlanID>', methods=['PUT'])
def update_artist_plan(ArtistID, ArtistPlanID):
    cursor = db.get_db().cursor()
    cursor.execute('UPDATE Artist SET ArtistPlanID = {0} WHERE ArtistID = {1}'.format(ArtistPlanID, ArtistID))
    db.get_db().commit()
    return "Success"
