-- This file is to bootstrap a database for the CS3200 project. 

-- Create a new database.  You can change the name later.  You'll
-- need this name in the FLASK API file(s),  the AppSmith 
-- data source creation.
create database Bopz;

-- Via the Docker Compose file, a special user called webapp will 
-- be created in MySQL. We are going to grant that user 
-- all privilages to the new database we just created. 
-- TODO: If you changed the name of the database above, you need 
-- to change it here too.
grant all privileges on Bopz.* to 'webapp'@'%';
flush privileges;

-- Move into the database we just created.
-- TODO: If you changed the name of the database above, you need to
-- change it here too. 


-- Put your DDL 

USE Bopz;




CREATE TABLE Admin
(
   AdminID   INTEGER PRIMARY KEY AUTO_INCREMENT,
   FirstName VARCHAR(40) NOT NULL,
   LastName  VARCHAR(40) NOT NULL,
   Title     VARCHAR(40) NOT NULL
);






CREATE TABLE AdvertisementPlan
(
   AdvertisementPlanID INTEGER PRIMARY KEY AUTO_INCREMENT,
   Cost                DOUBLE  NOT NULL,
   AdminId             INTEGER,
   AdType              VARCHAR(100),
   CONSTRAINT FOREIGN KEY fk_2 (AdminID) REFERENCES Admin (AdminID) ON DELETE restrict
);




CREATE TABLE Advertisor
(
   AdvertisementPlanID INTEGER,
   CompanyID           INTEGER,
   CompanyName         VARCHAR(40)  NOT NULL,
   Zip                 VARCHAR(8)   NOT NULL,
   State               CHAR(2)      NOT NULL,
   StreetAddress       VARCHAR(100) NOT NULL,
   PRIMARY KEY (AdvertisementPlanID, CompanyID),
   CONSTRAINT FOREIGN KEY fk_15 (AdvertisementPlanID) references AdvertisementPlan (AdvertisementPlanID)
       ON UPDATE cascade ON DELETE restrict
);




CREATE TABLE ArtistPlans
(
   PlanID             INTEGER PRIMARY KEY,
   PricePerListen     DOUBLE      NOT NULL,
   PlanName           VARCHAR(40) NOT NULL,
   AdminID            INTEGER     NOT NULL,
   CONSTRAINT FOREIGN KEY fk_3 (AdminID) REFERENCES Admin (AdminID) ON DELETE restrict
);




CREATE TABLE Artist
(
   ArtistID     INTEGER PRIMARY KEY AUTO_INCREMENT,
   FirstName    VARCHAR(40) NOT NULL,
   LastName     VARCHAR(40) NOT NULL,
   ArtistPlanID INTEGER     NOT NULL,
   Email        VARCHAR(50) NOT NULL,
   CONSTRAINT fk_4 FOREIGN KEY (ArtistPlanID) references ArtistPlans (PlanID)
       ON UPDATE CASCADE ON DELETE restrict




);




CREATE TABLE Genre
(
   GenreID INTEGER PRIMARY KEY,
   Name    varchar(100) NOT NULL
);




CREATE TABLE Album
(
   albumID    INTEGER PRIMARY KEY AUTO_INCREMENT,
   album_name VARCHAR(50) NOT NULL,
   artistID   INTEGER     NOT NULL,
   CONSTRAINT fk_5 FOREIGN KEY (ArtistID) references Artist (ArtistID) ON DELETE cascade
);




CREATE TABLE Song
(
   SongID   INTEGER Primary Key AUTO_INCREMENT,
   Title    VARCHAR(50) NOT NULL,
   Length   DOUBLE      NOT NULL,
   ArtistID INTEGER     NOT NULL,
   AlbumID  INTEGER(10) NOT NULL,
   GenreID  INTEGER(10) NOT NULL,
   CONSTRAINT FOREIGN KEY fk_6 (ArtistID) references Artist (ArtistID) ON DELETE cascade,
   CONSTRAINT FOREIGN KEY fk_7 (Albumid) references Album (AlbumID) ON DELETE cascade,
   CONSTRAINT FOREIGN KEY fk_8 (Genreid) references Genre (Genreid) ON DELETE cascade
);




CREATE TABLE SubscriptionType
(
   SubscriptionTypeID INTEGER PRIMARY KEY,
   Cost               DOUBLE      NOT NULL,
   Name               VARCHAR(50) NOT NULL,
   Length             INTEGER     NOT NULL,
   AdminID            INTEGER     NOT NULL,
   CONSTRAINT FOREIGN KEY fk_9 (AdminID) references Admin (AdminID) ON DELETE restrict
);




CREATE TABLE Listener
(
   ListenerID         INTEGER PRIMARY KEY AUTO_INCREMENT,
   Username           VARCHAR(50)  NOT NULL,
   Age                VARCHAR(4)   NOT NULL,
   Email              VARCHAR(100) NOT NULL,
   SubscriptionTypeID INTEGER      NOT NULL,
   CONSTRAINT FOREIGN KEY fk_10 (SubscriptionTypeID) references SubscriptionType (SubscriptionTypeID) ON UPDATE cascade ON DELETE restrict
);






CREATE TABLE ListenerPlays
(
   ListenerID  INTEGER,
   SongID      INTEGER,
   TimesPlayed INTEGER NOT NULL,
   PRIMARY KEY (ListenerID, SongID),
   CONSTRAINT FOREIGN KEY fk_11 (ListenerID) references Listener (ListenerID),
   CONSTRAINT FOREIGN KEY fk_12 (SongID) references Song (SongID) ON DELETE cascade
);
CREATE TABLE Playlists
(
   PlaylistID  INTEGER PRIMARY KEY AUTO_INCREMENT,
   Name        VARCHAR(50)  NOT NULL,
   Description VARCHAR(500) NOT NULL,
   ListenerID  INTEGER,
   SongID      INTEGER,
   CONSTRAINT FOREIGN KEY fk_13 (ListenerID) references Listener (ListenerID) ON DELETE cascade,
   CONSTRAINT FOREIGN KEY fk_14 (SongID) references Song (SongID) ON DELETE cascade
);




CREATE TABLE ArtistPayment
(
   ArtistID     INTEGER,
   ArtistPlanId INTEGER,
   TotalPaid    DOUBLE NOT NULL,
   PRIMARY KEY (ArtistID, ArtistPlanID),
   CONSTRAINT FOREIGN KEY fk_15 (ArtistID) references Artist (ArtistID) ON DELETE cascade,
   CONSTRAINT FOREIGN KEY fk_16 (ArtistPlanID) references ArtistPlans (PlanID) ON DELETE restrict
);


CREATE TABLE ArtistAlbum (
  albumID INTEGER,
  ArtistID INTEGER,
  PRIMARY KEY  (albumID, ArtistID),
  CONSTRAINT FOREIGN KEY fk_17 (albumID) REFERENCES Album (albumID),
  CONSTRAINT FOREIGN KEY fk_18 (ArtistID) REFERENCES Artist (ArtistID)
);

-- Add sample data. 

# create 10 admin
INSERT INTO Admin (FirstName, LastName, Title)
VALUES ('John', 'Doe', 'Manager');
INSERT INTO Admin (FirstName, LastName, Title)
VALUES ('Jane', 'Smith', 'Supervisor');
INSERT INTO Admin (FirstName, LastName, Title)
VALUES ('David', 'Lee', 'Director');
INSERT INTO Admin (FirstName, LastName, Title)
VALUES ('Samantha', 'Wilson', 'Coordinator');
INSERT INTO Admin (FirstName, LastName, Title)
VALUES ('Alex', 'Kim', 'Analyst');
INSERT INTO Admin (FirstName, LastName, Title)
VALUES ('Jessica', 'Chen', 'Assistant');
INSERT INTO Admin (FirstName, LastName, Title)
VALUES ('Mark', 'Taylor', 'Administrator');
INSERT INTO Admin (FirstName, LastName, Title)
VALUES ('Emily', 'Jones', 'Manager');
INSERT INTO Admin (FirstName, LastName, Title)
VALUES ('Ryan', 'Harris', 'Supervisor');
INSERT INTO Admin (FirstName, LastName, Title)
VALUES ('Grace', 'Liu', 'Director');

# create 5 ad plans
INSERT INTO AdvertisementPlan (Cost, AdminId, AdType)
VALUES (10.99, 3, 'Basic');
INSERT INTO AdvertisementPlan (Cost, AdminId, AdType)
VALUES (8.99, 7, 'Starter');
INSERT INTO AdvertisementPlan (Cost, AdminId, AdType)
VALUES (15.99, 5, 'Promo');
INSERT INTO AdvertisementPlan (Cost, AdminId, AdType)
VALUES (5.99, 2, 'Trial');
INSERT INTO AdvertisementPlan (Cost, AdminId, AdType)
VALUES (18.99, 9, 'Premium');


# create 15 advertisors

INSERT INTO Advertisor (AdvertisementPlanID, CompanyID, CompanyName, Zip, State, StreetAddress)
VALUES (1, 1, 'ABC Company', '12345', 'NY', '123 Main St');
INSERT INTO Advertisor (AdvertisementPlanID, CompanyID, CompanyName, Zip, State, StreetAddress)
VALUES (2, 2, 'XYZ Corp', '54321', 'CA', '456 Elm St');
INSERT INTO Advertisor (AdvertisementPlanID, CompanyID, CompanyName, Zip, State, StreetAddress)
VALUES (3, 3, 'Acme Inc', '67890', 'TX', '789 Oak St');
INSERT INTO Advertisor (AdvertisementPlanID, CompanyID, CompanyName, Zip, State, StreetAddress)
VALUES (4, 4, 'GHI Enterprises', '98765', 'FL', '321 Maple Ave');
INSERT INTO Advertisor (AdvertisementPlanID, CompanyID, CompanyName, Zip, State, StreetAddress)
VALUES (5, 5, 'LMN Industries', '45678', 'IL', '654 Pine St');
INSERT INTO Advertisor (AdvertisementPlanID, CompanyID, CompanyName, Zip, State, StreetAddress)
VALUES (1, 6, 'PQR Corp', '13579', 'CA', '789 Cherry Ln');
INSERT INTO Advertisor (AdvertisementPlanID, CompanyID, CompanyName, Zip, State, StreetAddress)
VALUES (2, 7, 'DEF Inc', '97531', 'TX', '246 Oak Ave');
INSERT INTO Advertisor (AdvertisementPlanID, CompanyID, CompanyName, Zip, State, StreetAddress)
VALUES (3, 8, 'UVW Company', '86420', 'NY', '369 Main St');
INSERT INTO Advertisor (AdvertisementPlanID, CompanyID, CompanyName, Zip, State, StreetAddress)
VALUES (4, 9, 'RST Enterprises', '75309', 'FL', '852 Elm St');
INSERT INTO Advertisor (AdvertisementPlanID, CompanyID, CompanyName, Zip, State, StreetAddress)
VALUES (5, 10, 'JKL Industries', '14785', 'IL', '963 Pine St');
INSERT INTO Advertisor (AdvertisementPlanID, CompanyID, CompanyName, Zip, State, StreetAddress)
VALUES (1, 11, 'MNO Corp', '25846', 'TX', '135 Cherry Ln');
INSERT INTO Advertisor (AdvertisementPlanID, CompanyID, CompanyName, Zip, State, StreetAddress)
VALUES (2, 12, 'PQR Inc', '36957', 'FL', '468 Oak Ave');
INSERT INTO Advertisor (AdvertisementPlanID, CompanyID, CompanyName, Zip, State, StreetAddress)
VALUES (3, 13, 'ABC Enterprises', '58246', 'IL', '579 Maple Ave');
INSERT INTO Advertisor (AdvertisementPlanID, CompanyID, CompanyName, Zip, State, StreetAddress)
VALUES (4, 14, 'DEF Industries', '69135', 'NY', '684 Pine St');
INSERT INTO Advertisor (AdvertisementPlanID, CompanyID, CompanyName, Zip, State, StreetAddress)
VALUES (5, 15, 'GHI Company', '13579', 'CA', '246 Main St');

# create 5 artist plans
INSERT INTO ArtistPlans (PlanID, PricePerListen, PlanName, AdminID)
VALUES (1, 0.50, 'Plan A', 5);
INSERT INTO ArtistPlans (PlanID, PricePerListen, PlanName, AdminID)
VALUES (2, 1.25, 'Plan B', 2);
INSERT INTO ArtistPlans (PlanID, PricePerListen, PlanName, AdminID)
VALUES (3, 0.10, 'Plan C', 9);
INSERT INTO ArtistPlans (PlanID, PricePerListen, PlanName, AdminID)
VALUES (4, 2.50, 'Plan D', 1);
INSERT INTO ArtistPlans (PlanID, PricePerListen, PlanName, AdminID)
VALUES (5, 0.75, 'Plan E', 8);

# create 20 artists
INSERT INTO Artist (FirstName, LastName, ArtistPlanID, Email)
VALUES ('John', 'Smith', 1, 'johnsmith@gmail.com');
INSERT INTO Artist (FirstName, LastName, ArtistPlanID, Email)
VALUES ('Amanda', 'Lee', 2, 'amandalee@yahoo.com');
INSERT INTO Artist (FirstName, LastName, ArtistPlanID, Email)
VALUES ('David', 'Kim', 3, 'davidkim@hotmail.com');
INSERT INTO Artist (FirstName, LastName, ArtistPlanID, Email)
VALUES ('Emily', 'Chang', 4, 'emilychang@gmail.com');
INSERT INTO Artist (FirstName, LastName, ArtistPlanID, Email)
VALUES ('Jacob', 'Nguyen', 5, 'jacobnguyen@yahoo.com');
INSERT INTO Artist (FirstName, LastName, ArtistPlanID, Email)
VALUES ('Sara', 'Park', 1, 'sarapark@hotmail.com');
INSERT INTO Artist (FirstName, LastName, ArtistPlanID, Email)
VALUES ('James', 'Kwak', 2, 'jameskwak@gmail.com');
INSERT INTO Artist (FirstName, LastName, ArtistPlanID, Email)
VALUES ('Lena', 'Choi', 3, 'lenachoi@yahoo.com');
INSERT INTO Artist (FirstName, LastName, ArtistPlanID, Email)
VALUES ('Ryan', 'Lee', 4, 'ryanlee@hotmail.com');
INSERT INTO Artist (FirstName, LastName, ArtistPlanID, Email)
VALUES ('Grace', 'Wu', 5, 'gracewu@gmail.com');
INSERT INTO Artist (FirstName, LastName, ArtistPlanID, Email)
VALUES ('John', 'Doe', 1, 'johndoe@email.com');
INSERT INTO Artist (FirstName, LastName, ArtistPlanID, Email)
VALUES ('Sarah', 'Smith', 2, 'sarahsmith@email.com');
INSERT INTO Artist (FirstName, LastName, ArtistPlanID, Email)
VALUES ('Tom', 'Jones', 3, 'tomjones@email.com');
INSERT INTO Artist (FirstName, LastName, ArtistPlanID, Email)
VALUES ('Jessica', 'Johnson', 4, 'jessicajohnson@email.com');
INSERT INTO Artist (FirstName, LastName, ArtistPlanID, Email)
VALUES ('Michael', 'Jackson', 5, 'michaeljackson@email.com');
INSERT INTO Artist (FirstName, LastName, ArtistPlanID, Email)
VALUES ('David', 'Bowie', 1, 'davidbowie@email.com');
INSERT INTO Artist (FirstName, LastName, ArtistPlanID, Email)
VALUES ('Janis', 'Joplin', 2, 'janisjoplin@email.com');
INSERT INTO Artist (FirstName, LastName, ArtistPlanID, Email)
VALUES ('Elvis', 'Presley', 3, 'elvispresley@email.com');
INSERT INTO Artist (FirstName, LastName, ArtistPlanID, Email)
VALUES ('Freddie', 'Mercury', 4, 'freddiemercury@email.com');
INSERT INTO Artist (FirstName, LastName, ArtistPlanID, Email)
VALUES ('Prince', 'Rogers Nelson', 5, 'prince@email.com');

# create 10 musical genres
INSERT INTO Genre (GenreID, Name)
VALUES (1, 'Rock');
INSERT INTO Genre (GenreID, Name)
VALUES (2, 'Pop');
INSERT INTO Genre (GenreID, Name)
VALUES (3, 'Hip Hop');
INSERT INTO Genre (GenreID, Name)
VALUES (4, 'Country');
INSERT INTO Genre (GenreID, Name)
VALUES (5, 'Jazz');
INSERT INTO Genre (GenreID, Name)
VALUES (6, 'Electronic');
INSERT INTO Genre (GenreID, Name)
VALUES (7, 'R&B');
INSERT INTO Genre (GenreID, Name)
VALUES (8, 'Classical');
INSERT INTO Genre (GenreID, Name)
VALUES (9, 'Reggae');
INSERT INTO Genre (GenreID, Name)
VALUES (10, 'Blues');

# create 20 albums
INSERT INTO Album (album_name, artistID)
VALUES ('Gumbo', 1);
INSERT INTO Album (album_name, artistID)
VALUES ('Jazz on the Bayou', 2);
INSERT INTO Album (album_name, artistID)
VALUES ('Creole Nights', 3);
INSERT INTO Album (album_name, artistID)
VALUES ('Programmer Heaven', 4);
INSERT INTO Album (album_name, artistID)
VALUES ('Control Shift', 5);
INSERT INTO Album (album_name, artistID)
VALUES ('Save As', 6);
INSERT INTO Album (album_name, artistID)
VALUES ('Going Up', 7);
INSERT INTO Album (album_name, artistID)
VALUES ('Northeastern', 8);
INSERT INTO Album (album_name, artistID)
VALUES ('When in the Area', 9);
INSERT INTO Album (album_name, artistID)
VALUES ('Oil Slick', 10);
INSERT INTO Album (album_name, artistID)
VALUES ('Drilling for Gold', 11);
INSERT INTO Album (album_name, artistID)
VALUES ('Tar Sands Tango', 12);
INSERT INTO Album (album_name, artistID)
VALUES ('Cream or Sugar', 13);
INSERT INTO Album (album_name, artistID)
VALUES ('The Regular', 14);
INSERT INTO Album (album_name, artistID)
VALUES ('Morning Fuel', 15);
INSERT INTO Album (album_name, artistID)
VALUES ('Journey', 16);
INSERT INTO Album (album_name, artistID)
VALUES ('Destination', 17);
INSERT INTO Album (album_name, artistID)
VALUES ('A Trip Around', 18);
INSERT INTO Album (album_name, artistID)
VALUES ('Book Lovers', 19);
INSERT INTO Album (album_name, artistID)
VALUES ('Brains Over Beauty', 20);

# create 100 songs
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Louisiana Blues', 3.25, 1, 1, 1);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Louisiana Man', 2.58, 1, 1, 2);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Down in Louisiana', 4.02, 1, 1, 3);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Louisiana 1927', 3.52, 1, 1, 4);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Louisiana 1927 (Live)', 4.11, 2, 2, 4);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('The Battle of New Orleans', 3.03, 2, 2, 5);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Jambalaya (On the Bayou)', 2.56, 2, 2, 6);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Louisiana Saturday Night', 2.24, 2, 2, 7);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('When the Saints Go Marching In', 3.21, 2, 2, 8);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Mardi Gras Mambo', 2.52, 3, 3, 9);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Iko Iko', 2.42, 3, 3, 10);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Meet Me in New Orleans', 3.45, 3, 3, 1);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('New Orleans Ladies', 4.00, 3, 3, 2);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Louisiana Woman, Mississippi Man', 2.26, 3, 3, 3);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Louisiana Hayride', 3.12, 3, 3, 4);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Robot Rock', 4.32, 4, 4, 1);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('The Grid', 3.50, 4, 4, 2);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Digital Love 2.0', 5.02, 4, 4, 1);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Byte Me', 3.21, 5, 5, 6);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Wired', 3.48, 5, 5, 8);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Code Red', 4.01, 5, 5, 9);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Cybernetic Soul', 5.11, 6, 6, 3);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Electronic Dreams', 4.25, 6, 6, 4);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('AI Overload', 3.59, 6, 6, 5);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Digital Heartache', 3.14, 4, 4, 6);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Silicon Valley', 4.27, 4, 4, 7);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Circuit Board Romance', 5.23, 4, 4, 8);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('The Code Breaker', 3.50, 5, 5, 9);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Techno Wizard', 4.15, 5, 5, 10);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Digital Apocalypse', 3.59, 5, 5, 5);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Boston Blues', 4.32, 7, 7, 1);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('New York Nights', 3.50, 7, 7, 2);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Philadelphia Freedom', 5.02, 7, 7, 1);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('New England Dreams', 3.21, 8, 8, 6);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Vermont Vista', 3.48, 8, 8, 8);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Connecticut Conundrum', 4.01, 8, 8, 9);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Maine Memories', 5.11, 9, 9, 3);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Rhode Island Rhapsody', 4.25, 9, 9, 4);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('New Hampshire Nights', 3.59, 9, 9, 5);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Boston Beats', 3.14, 7, 7, 6);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('New York Groove', 4.27, 7, 7, 7);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Philly Funk', 5.23, 7, 7, 8);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('The Connecticut Kid', 3.50, 8, 8, 9);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Vermont Victory', 4.15, 8, 8, 10);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Maine Mystery', 3.59, 9, 9, 5);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Oil Slick', 3.52, 10, 10, 1);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Drilling for Gold', 2.49, 11, 11, 2);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Black Gold', 4.17, 11, 11, 1);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Crude Awakening', 5.21, 12, 12, 3);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Oil and Water', 3.15, 12, 12, 3);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Petroglyphs', 4.02, 10, 10, 4);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Fossil Fuel Blues', 3.56, 11, 11, 5);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Oil Rig Rhapsody', 2.58, 8, 12, 6);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Gusher Groove', 4.45, 10, 10, 10);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Frack Attack', 3.31, 11, 11, 7);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Tar Sands Tango', 5.14, 12, 12, 2);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Petroleum Blues', 4.18, 10, 10, 9);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Refinery Rag', 2.37, 11, 11, 7);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Crude Oil Stomp', 3.08, 12, 12, 8);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Pipeline Polka', 4.09, 10, 10, 10);
INSERT INTO Song(Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Java Jive', 3.28, 13, 13, 1);
INSERT INTO Song(Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Black Coffee', 5.29, 13, 13, 2);
INSERT INTO Song(Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Cup of Joe', 4.21, 14, 14, 3);
INSERT INTO Song(Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Coffee Time', 3.49, 14, 14, 4);
INSERT INTO Song(Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Mocha Choca Latte', 4.02, 13, 13, 5);
INSERT INTO Song(Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Espresso Yourself', 2.57, 15, 15, 6);
INSERT INTO Song(Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Brew Crew', 3.41, 15, 15, 7);
INSERT INTO Song(Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Coffee and Cigarettes', 4.07, 13, 13, 8);
INSERT INTO Song(Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Iced Coffee Blues', 4.45, 15, 15, 9);
INSERT INTO Song(Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Latte Love', 3.21, 13, 13, 10);
INSERT INTO Song(Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('The Coffee Song', 2.32, 14, 14, 1);
INSERT INTO Song(Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Bittersweet Bean', 5.01, 14, 14, 2);
INSERT INTO Song(Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Java Junkie', 4.18, 15, 15, 3);
INSERT INTO Song(Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Caffeine Dream', 3.54, 15, 15, 4);
INSERT INTO Song(Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Coffeehouse Serenade', 3.27, 15, 15, 5);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Train to Nowhere', 3.5, 16, 16, 4);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Riding the Rails', 4.2, 16, 16, 2);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Boxcar Blues', 2.9, 17, 17, 8);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Locomotive Lament', 3.8, 17, 17, 3);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('The Train Keeps Rolling', 3.1, 16, 16, 5);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Whistle Stop', 2.7, 18, 18, 9);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Train of Thought', 3.9, 18, 18, 1);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Steel Rails', 4.5, 16, 16, 6);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('The Last Train', 2.8, 17, 17, 10);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Train Whistle Blues', 3.3, 18, 18, 7);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Chugging Along', 3.6, 16, 16, 2);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Freight Train Boogie', 2.5, 17, 17, 5);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Engine Number Nine', 4.0, 18, 18, 4);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('The Midnight Special', 3.7, 16, 16, 8);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Train Wreck', 2.2, 17, 17, 3);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Back to School', 3.5, 19, 19, 2);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Math Class Blues', 4.2, 19, 19, 4);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Science Rocks!', 2.8, 20, 20, 1);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('History Lessons', 3.1, 20, 20, 3);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Homework Time', 4.0, 19, 19, 5);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Campus Life', 3.9, 19, 19, 8);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Studying Hard', 4.5, 20, 20, 6);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('First Day Jitters', 2.9, 20, 20, 2);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Dormitory Living', 3.7, 19, 19, 7);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Dean''s List', 4.2, 19, 19, 10);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Campus Crush', 3.6, 20, 20, 9);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Library Hours', 2.5, 20, 20, 1);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('The Freshman Fifteen', 3.8, 19, 19, 5);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Senioritis Blues', 4.3, 19, 19, 4);
INSERT INTO Song (Title, Length, ArtistID, AlbumID, GenreID)
VALUES ('Graduation Day', 3.2, 20, 20, 7);

# Create 5 subscription types
INSERT INTO SubscriptionType (SubscriptionTypeID, Cost, Name, Length, AdminID)
VALUES (1, 9.99, 'Basic', 30, 1);
INSERT INTO SubscriptionType (SubscriptionTypeID, Cost, Name, Length, AdminID)
VALUES (2, 14.99, 'Premium', 60, 3);
INSERT INTO SubscriptionType (SubscriptionTypeID, Cost, Name, Length, AdminID)
VALUES (3, 19.99, 'Elite', 90, 5);
INSERT INTO SubscriptionType (SubscriptionTypeID, Cost, Name, Length, AdminID)
VALUES (4, 12.99, 'Silver', 45, 7);
INSERT INTO SubscriptionType (SubscriptionTypeID, Cost, Name, Length, AdminID)
VALUES (5, 17.99, 'Gold', 75, 9);

# Create 30 Listeners
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('rockstar88', '25', 'rockstar88@example.com', 1);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('musiclover123', '32', 'musiclover123@example.com', 2);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('guitarhero22', '19', 'guitarhero22@example.com', 1);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('songbird_7', '28', 'songbird_7@example.com', 4);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('jazzmaster34', '42', 'jazzmaster34@example.com', 3);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('musicfanatic99', '21', 'musicfanatic99@example.com', 2);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('rhythmkid14', '16', 'rhythmkid14@example.com', 1);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('songlover89', '29', 'songlover89@example.com', 3);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('melodymaker27', '24', 'melodymaker27@example.com', 2);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('groovemaster5', '37', 'groovemaster5@example.com', 4);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('bassplayer77', '31', 'bassplayer77@example.com', 5);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('singer14', '27', 'singer14@example.com', 1);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('rhythmgirl22', '18', 'rhythmgirl22@example.com', 3);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('musicproducer10', '39', 'musicproducer10@example.com', 4);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('songwriter27', '26', 'songwriter27@example.com', 2);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('jennyLuv', '24', 'jennyLuv@email.com', 1);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('davidMusic', '31', 'davidMusic@email.com', 2);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('musicLover', '28', 'musicLover@email.com', 3);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('jimmyJams', '22', 'jimmyJams@email.com', 4);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('melodyMuse', '27', 'melodyMuse@email.com', 5);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('rhythmicRanger', '20', 'rhythmicRanger@email.com', 1);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('harmoniousHolly', '26', 'harmoniousHolly@email.com', 2);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('beatBoss', '29', 'beatBoss@email.com', 3);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('tuneTastic', '24', 'tuneTastic@email.com', 4);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('audioAddict', '23', 'audioAddict@email.com', 5);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('soundSavvy', '30', 'soundSavvy@email.com', 1);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('musicMania', '21', 'musicMania@email.com', 2);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('rhythmRider', '25', 'rhythmRider@email.com', 3);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('harmonyHunter', '27', 'harmonyHunter@email.com', 4);
INSERT INTO Listener (Username, Age, Email, SubscriptionTypeID)
VALUES ('beatBaller', '29', 'beatBaller@email.com', 5);

# create 20 playlists
INSERT INTO Playlists (Name, Description, ListenerID, SongID)
VALUES ('My Favorite Songs', 'A playlist of my favorite songs', 1, 1);
INSERT INTO Playlists (Name, Description, ListenerID, SongID)
VALUES ('Running Playlist', 'A playlist to listen to while running', 2, 5);
INSERT INTO Playlists (Name, Description, ListenerID, SongID)
VALUES ('Chill Vibes', 'A playlist of relaxing songs', 3, 7);
INSERT INTO Playlists (Name, Description, ListenerID, SongID)
VALUES ('Party Mix', 'A playlist of upbeat songs for a party', 4, 11);
INSERT INTO Playlists (Name, Description, ListenerID, SongID)
VALUES ('Country Jams', 'A playlist of my favorite country songs', 5, 23);
INSERT INTO Playlists (Name, Description, ListenerID, SongID)
VALUES ('Road Trip Tunes', 'A playlist for a long road trip', 6, 36);
INSERT INTO Playlists (Name, Description, ListenerID, SongID)
VALUES ('Throwback Hits', 'A playlist of classic hits', 7, 41);
INSERT INTO Playlists (Name, Description, ListenerID, SongID)
VALUES ('Rock On', 'A playlist of rock music', 8, 59);
INSERT INTO Playlists (Name, Description, ListenerID, SongID)
VALUES ('Hip Hop Hooray', 'A playlist of hip hop music', 9, 67);
INSERT INTO Playlists (Name, Description, ListenerID, SongID)
VALUES ('Romantic Songs', 'A playlist of romantic songs', 10, 74);
INSERT INTO Playlists (Name, Description, ListenerID, SongID)
VALUES ('Pump Up the Jam', 'A playlist of high-energy music', 11, 81);
INSERT INTO Playlists (Name, Description, ListenerID, SongID)
VALUES ('90s Nostalgia', 'A playlist of 90s hits', 12, 99);
INSERT INTO Playlists (Name, Description, ListenerID, SongID)
VALUES ('Jazz It Up', 'A playlist of jazz music', 13, 14);
INSERT INTO Playlists (Name, Description, ListenerID, SongID)
VALUES ('Dance Party', 'A playlist of dance music', 14, 29);
INSERT INTO Playlists (Name, Description, ListenerID, SongID)
VALUES ('Pop Sensations', 'A playlist of popular songs', 15, 38);
INSERT INTO Playlists (Name, Description, ListenerID, SongID)
VALUES ('Indie Vibes', 'A playlist of indie music', 16, 50);
INSERT INTO Playlists (Name, Description, ListenerID, SongID)
VALUES ('Metal Madness', 'A playlist of heavy metal music', 17, 68);
INSERT INTO Playlists (Name, Description, ListenerID, SongID)
VALUES ('Study Session', 'A playlist for studying', 18, 76);
INSERT INTO Playlists (Name, Description, ListenerID, SongID)
VALUES ('Relax and Unwind', 'A playlist of calming music', 19, 85);
INSERT INTO Playlists (Name, Description, ListenerID, SongID)
VALUES ('Christmas Cheer', 'A playlist of Christmas music', 20, 92);

# insert each artist a value in artistpayment
INSERT INTO ArtistPayment (ArtistID, ArtistPlanID, TotalPaid)
VALUES (1, 1, 2000.00);
INSERT INTO ArtistPayment (ArtistID, ArtistPlanID, TotalPaid)
VALUES (2, 2, 5000.00);
INSERT INTO ArtistPayment (ArtistID, ArtistPlanID, TotalPaid)
VALUES (3, 3, 3000.00);
INSERT INTO ArtistPayment (ArtistID, ArtistPlanID, TotalPaid)
VALUES (4, 4, 1500.00);
INSERT INTO ArtistPayment (ArtistID, ArtistPlanID, TotalPaid)
VALUES (5, 5, 8000.00);
INSERT INTO ArtistPayment (ArtistID, ArtistPlanID, TotalPaid)
VALUES (6, 1, 2500.00);
INSERT INTO ArtistPayment (ArtistID, ArtistPlanID, TotalPaid)
VALUES (7, 2, 12000.00);
INSERT INTO ArtistPayment (ArtistID, ArtistPlanID, TotalPaid)
VALUES (8, 3, 4000.00);
INSERT INTO ArtistPayment (ArtistID, ArtistPlanID, TotalPaid)
VALUES (9, 4, 1800.00);
INSERT INTO ArtistPayment (ArtistID, ArtistPlanID, TotalPaid)
VALUES (10, 5, 3500.00);
INSERT INTO ArtistPayment (ArtistID, ArtistPlanID, TotalPaid)
VALUES (11, 1, 5500.00);
INSERT INTO ArtistPayment (ArtistID, ArtistPlanID, TotalPaid)
VALUES (12, 2, 3200.00);
INSERT INTO ArtistPayment (ArtistID, ArtistPlanID, TotalPaid)
VALUES (13, 3, 9000.00);
INSERT INTO ArtistPayment (ArtistID, ArtistPlanID, TotalPaid)
VALUES (14, 4, 2100.00);
INSERT INTO ArtistPayment (ArtistID, ArtistPlanID, TotalPaid)
VALUES (15, 5, 7500.00);
INSERT INTO ArtistPayment (ArtistID, ArtistPlanID, TotalPaid)
VALUES (16, 1, 3800.00);
INSERT INTO ArtistPayment (ArtistID, ArtistPlanID, TotalPaid)
VALUES (17, 2, 4200.00);
INSERT INTO ArtistPayment (ArtistID, ArtistPlanID, TotalPaid)
VALUES (18, 3, 2700.00);
INSERT INTO ArtistPayment (ArtistID, ArtistPlanID, TotalPaid)
VALUES (19, 4, 11000.00);
INSERT INTO ArtistPayment (ArtistID, ArtistPlanID, TotalPaid)
VALUES (20, 5, 6800.00);

# add albums/artists into album/artist
INSERT INTO ArtistAlbum (albumID, ArtistID) VALUES (1, 1);
INSERT INTO ArtistAlbum (albumID, ArtistID) VALUES (2, 2);
INSERT INTO ArtistAlbum (albumID, ArtistID) VALUES (3, 3);
INSERT INTO ArtistAlbum (albumID, ArtistID) VALUES (4, 4);
INSERT INTO ArtistAlbum (albumID, ArtistID) VALUES (5, 5);
INSERT INTO ArtistAlbum (albumID, ArtistID) VALUES (6, 6);
INSERT INTO ArtistAlbum (albumID, ArtistID) VALUES (7, 7);
INSERT INTO ArtistAlbum (albumID, ArtistID) VALUES (8, 8);
INSERT INTO ArtistAlbum (albumID, ArtistID) VALUES (9, 9);
INSERT INTO ArtistAlbum (albumID, ArtistID) VALUES (10, 10);
INSERT INTO ArtistAlbum (albumID, ArtistID) VALUES (11, 11);
INSERT INTO ArtistAlbum (albumID, ArtistID) VALUES (12, 12);
INSERT INTO ArtistAlbum (albumID, ArtistID) VALUES (13, 13);
INSERT INTO ArtistAlbum (albumID, ArtistID) VALUES (14, 14);
INSERT INTO ArtistAlbum (albumID, ArtistID) VALUES (15, 15);
INSERT INTO ArtistAlbum (albumID, ArtistID) VALUES (16, 16);
INSERT INTO ArtistAlbum (albumID, ArtistID) VALUES (17, 17);
INSERT INTO ArtistAlbum (albumID, ArtistID) VALUES (18, 18);
INSERT INTO ArtistAlbum (albumID, ArtistID) VALUES (19, 19);
INSERT INTO ArtistAlbum (albumID, ArtistID) VALUES (20, 20);

# put in some beginning listenerplays information
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (1, 1, 10);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (2, 2, 5);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (3, 3, 20);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (4, 4, 15);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (5, 5, 8);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (6, 6, 4);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (7, 7, 12);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (8, 8, 9);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (9, 9, 25);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (10, 10, 7);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (11, 11, 16);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (12, 12, 3);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (13, 13, 18);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (14, 14, 11);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (15, 15, 6);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (16, 16, 14);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (17, 17, 22);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (18, 18, 1);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (19, 19, 19);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (20, 20, 13);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (7, 36, 2);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (2, 62, 5);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (25, 12, 1);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (13, 92, 3);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (19, 28, 1);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (18, 56, 2);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (30, 40, 4);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (14, 73, 1);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (9, 95, 2);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (4, 89, 3);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (22, 79, 5);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (3, 42, 1);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (10, 64, 2);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (16, 17, 1);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (29, 84, 3);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (21, 31, 4);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (5, 76, 2);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (27, 19, 1);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (6, 70, 3);
INSERT INTO ListenerPlays (ListenerID, SongID, TimesPlayed) VALUES (12, 53, 2);


















