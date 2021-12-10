# frozen_string_literal: true

require 'pg'
require 'singleton'

class Setup
  include Singleton
  def truncate
    p 'Connecting to test database...'
    con = PG.connect(dbname: 'bookmark_manager_test')
    p 'Cleaning up test database...'
    con.exec('TRUNCATE bookmarks')
  end
end
