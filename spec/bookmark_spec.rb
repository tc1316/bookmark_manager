# frozen_string_literal: true
require_relative './database_helper'
require 'bookmark'

describe Bookmark do
  context '#all'
  it 'returns an array of bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    bookmark1 = Bookmark.create('http://www.makersacademy.com', 'makers')
    Bookmark.create('http://www.destroyallsoftware.com', 'destroyallsoftware')
    Bookmark.create('http://www.google.com', 'google')
    
    bm = Bookmark.all # Returns list of Bookmark instances

    expect(bm.length).to eq 3
    expect(bm.first).to be_a Bookmark
    expect(bm.first.id).to eq bookmark1.id
    expect(bm.first.title).to eq 'makers'
    expect(bm.first.url).to eq 'http://www.makersacademy.com'
  end

  context '#create'
  it 'can create new bookmarks' do
    bookmark = Bookmark.create('http://www.makersacademy.com', 'makers')
    persisted_data = persisted_data(bookmark.id) # Returning id, url, title of above Bookmark instance using the id as the locator

    expect(bookmark).to be_a Bookmark
    expect(bookmark.id).to eq persisted_data['id']
    # expect(Bookmark.all.first.id).to eq persisted_data['id']
    expect(bookmark.title).to eq 'makers'
    # expect(Bookmark.all.first.title). to eq 'makers'
    expect(bookmark.url).to eq 'http://www.makersacademy.com'
    # expect(Bookmark.all.first.url). to eq 'http://www.makersacademy.com'

    
  end
end
