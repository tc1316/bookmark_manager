# frozen_string_literal: true

require 'capybara/rspec'
require_relative '../../app'
Capybara.app = BookmarkManager
require 'bookmark'

feature 'visiting Bookmarks' do
  scenario 'shows bookmarks' do
    Bookmark.create('http://www.makersacademy.com', 'Makers Academy')
    Bookmark.create('http://www.destroyallsoftware.com', 'Destroy All Software')
    Bookmark.create('http://www.google.com', 'Google')

    visit('/bookmarks')

    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com').once
    expect(page).to have_link('Destroy All Software',  href: 'http://www.destroyallsoftware.com').once
    expect(page).to have_link('Google', href: 'http://www.google.com').once
  end
end
