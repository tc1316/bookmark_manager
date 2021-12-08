require 'capybara/rspec'
require_relative '../../app'
Capybara.app = BookmarkManager
require 'bookmark'

feature 'visiting Bookmarks' do
  scenario 'shows bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    Bookmark.create('http://www.makersacademy.com')
    Bookmark.create('http://www.destroyallsoftware.com')
    Bookmark.create('http://www.google.com')

    visit('/bookmarks')

    expect(page).to have_content("http://www.makersacademy.com").once
    expect(page).to have_content("http://www.destroyallsoftware.com").once
    expect(page).to have_content("http://www.google.com").once
  end
end
