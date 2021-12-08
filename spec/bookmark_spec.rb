# frozen_string_literal: true

require 'bookmark'

describe Bookmark do
  let(:bookmark) { described_class }

  context '#all'
  it 'returns an array of bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("INSERT INTO bookmarks (url, title) VALUES ('http://www.makersacademy.com', 'makers');")
    connection.exec("INSERT INTO bookmarks (url, title) VALUES('http://www.destroyallsoftware.com', 'destroyallsoftware');")
    connection.exec("INSERT INTO bookmarks (url, title) VALUES('http://www.google.com', 'google');")
    expect(bookmark.all).to match_array(["destroyallsoftware : http://www.destroyallsoftware.com", "google : http://www.google.com", "makers : http://www.makersacademy.com"])
  end

  context '#create'
  it 'can add new bookmarks' do
    PG.connect(dbname: 'bookmark_manager_test')
    bookmark.create('http://www.makersacademy.com', 'makers')
    bookmark.create('http://www.destroyallsoftware.com', 'destroyallsoftware')
    bookmark.create('http://www.google.com', 'google')

    expect(bookmark.all).to match_array(["destroyallsoftware : http://www.destroyallsoftware.com", "google : http://www.google.com", "makers : http://www.makersacademy.com"])
  end
end
