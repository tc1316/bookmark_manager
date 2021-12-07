# User story

As a user
So that I can see my bookmarks
I would like to view altogether them as a list

## Domain Model

class/object => BookmarkManager
variables => @list_of_bookmarks: []
messages => list_bookmarks()

## How to set-up the database

1. Connect to psql
2. Create the database using the psql command CREATE DATABASE bookmark_manager;
3. Connect to the database using the pqsl command \c bookmark_manager;
4. Run the query we have saved in the file 01_create_bookmarks_table.sql