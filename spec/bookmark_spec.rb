# frozen_string_literal: true

require 'bookmark'

describe Bookmark do
  let(:bookmark) { described_class }

  context '#all'
  it 'returns an array of bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.makersacademy.com');")
    connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.destroyallsoftware.com');")
    connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.google.com');")
    expect(bookmark.all).to match_array(['http://www.makersacademy.com', 'http://www.destroyallsoftware.com', 'http://www.google.com'])
  end

  context '#create'
  it 'can add new bookmarks' do
    PG.connect(dbname: 'bookmark_manager_test')
    bookmark.create('http://www.makersacademy.com')
    bookmark.create('http://www.destroyallsoftware.com')
    bookmark.create('http://www.google.com')
    expect(bookmark.all).to match_array(['http://www.makersacademy.com', 'http://www.destroyallsoftware.com', 'http://www.google.com'])
  end
end
