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
    rs.map { |bookmark| bookmark['title'] + ' : ' + bookmark['url'] }
    # Returns array of values from url as key
  end

  def self.create(url, title)
    con = if ENV['CUSTOM_ENV_TYPE'] == 'test'
            PG.connect(dbname: 'bookmark_manager_test')
          else
            PG.connect(dbname: 'bookmark_manager')
          end

    con.exec("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}');")
  end
end
