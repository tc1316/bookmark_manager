# frozen_string_literal: true

require 'pg'

class Bookmark
  def self.all
    con = if ENV['CUSTOM_ENV_TYPE'] == 'test'
            PG.connect(dbname: 'bookmark_manager_test')
          else
            PG.connect(dbname: 'bookmark_manager')
          end

    rs = con.exec('SELECT * FROM bookmarks')
    rs.map { |bookmark| bookmark['url'] }
    # Returns array of values from url as key
  end

  def self.create(url)
    con = if ENV['CUSTOM_ENV_TYPE'] == 'test'
            PG.connect(dbname: 'bookmark_manager_test')
          else
            PG.connect(dbname: 'bookmark_manager')
          end

    con.exec("INSERT INTO bookmarks (url) VALUES ('#{url}');")
  end
end
