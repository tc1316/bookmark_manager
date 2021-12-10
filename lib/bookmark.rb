# frozen_string_literal: true

require 'pg'
require_relative './db_con'
require 'uri'

class Bookmark
  attr_reader :id, :url, :title

  def initialize(id, url, title)
    @id = id
    @url = url
    @title = title
  end

  def self.all
    rs = DatabaseConnection.query('SELECT * FROM bookmarks')
    rs.map { |bookmark| Bookmark.new(bookmark['id'], bookmark['url'], bookmark['title']) }
  end

  def self.create(url, title)
    if url =~ URI::regexp
      rs = DatabaseConnection.query('INSERT INTO bookmarks (url, title) VALUES ($1, $2) RETURNING id, url, title;',
                                  [url, title])
    else
      return false
    end                                 
    # rs is the query object, hence the need to [0] to access the hash containing id, url and title kv pairs
    Bookmark.new(rs[0]['id'], rs[0]['url'], rs[0]['title'])
  end

  def self.delete(id)
    DatabaseConnection.query('DELETE FROM bookmarks WHERE id = $1', [id])
  end

  def self.update(id, url, title)
    if url =~ URI::regexp
        rs = DatabaseConnection.query('UPDATE bookmarks SET url = $1, title = $2 WHERE id = $3 RETURNING id, url, title;',
                                  [url, title, id])
    else
      return url
    end                                
    Bookmark.new(rs[0]['id'], rs[0]['url'], rs[0]['title'])
  end

  def self.find(id)
    rs = DatabaseConnection.query('SELECT * FROM bookmarks WHERE id = $1;', [id])
    Bookmark.new(rs[0]['id'], rs[0]['url'], rs[0]['title'])
  end
end
