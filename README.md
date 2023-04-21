# The Bopz App
### Link to our video: https://drive.google.com/file/d/1UoGshQdZ1_WZqwWJ92t4zpu93OE7UlTr/view
### Link to our Appsmith UI: https://github.com/yeje88/Bopz_theFinal

The Bopz app is a music platform focused on highlighting up and coming artists. This repository contains code for three docker containers that make up the project - a MySQL database container, python flask container, and local appsmith server. Using this code, the containers are configured throguh the docker-compose.yml file. With these docker containers and proper setup (specified in sections below), the app provides two user profiles for a standard listener and artist.

## Python Flask Blueprint Organization

The python flack container is organized by 3 blueprints - one for the listener user, one for the artist users, and one for songs. With the first two we have two different login profiles that allow users to enter an account and trigger API calls tied to the id they select at the drown downs on the home page. Most of the API calls under listener focus on the playlists that listeners can create and manage songs in. Meanwhile, for artists, most of the API calls focus on managing or viewing statistics of songs within the artist's albums. This makes songs the middle ground between the ueuser profiles which is while it is a separate third blueprint. 

Each listenener and artist blueprint contain one GET, POST, PUT, and DELETE method. In addition, each path with arguments has two thunder client tests and each path without arguments has one thunder client test. GET tests we executed by ensuring that the status code was 200. For the remaining method types, the tests were executed by ensuring the response returned "Success".


# MySQL + Flask Boilerplate Project Containers

This repo contains a boilerplate setup for spinning up 3 Docker containers: 
1. A MySQL 8 container for obvious reasons
1. A Python Flask container to implement a REST API
1. A Local AppSmith Server

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 

# We hope you enjoy the App! ~ The Bopz Team
