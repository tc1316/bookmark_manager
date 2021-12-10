# frozen_string_literal: true

require 'pg'

class Bookmark
  attr_reader :id, :url, :title

  def initialize(id, url, title)
    @id = id
    @url = url
    @title = title
  end

  def self.all
    con = if ENV['CUSTOM_ENV_TYPE'] == 'test'
            PG.connect(dbname: 'bookmark_manager_test')
          else
            PG.connect(dbname: 'bookmark_manager')
          end

    rs = con.exec('SELECT * FROM bookmarks')

    rs.map { |bookmark| Bookmark.new(bookmark['id'], bookmark['url'], bookmark['title']) }
  end

  def self.create(url, title)
    con = if ENV['CUSTOM_ENV_TYPE'] == 'test'
            PG.connect(dbname: 'bookmark_manager_test')
          else
            PG.connect(dbname: 'bookmark_manager')
          end

    rs = con.exec_params('INSERT INTO bookmarks (url, title) VALUES ($1, $2) RETURNING id, url, title;', [url, title])
    # rs is the query object, hence the need to .first (aka [0]) to access the hash containing id, url and title kv pairs
    Bookmark.new(rs[0]['id'], rs[0]['url'], rs[0]['title'])
  end

  def self.delete(id)
    con = if ENV['CUSTOM_ENV_TYPE'] == 'test'
            PG.connect(dbname: 'bookmark_manager_test')
          else
            PG.connect(dbname: 'bookmark_manager')
          end
    con.exec_params('DELETE FROM bookmarks WHERE id = $1', [id])
  end
end
