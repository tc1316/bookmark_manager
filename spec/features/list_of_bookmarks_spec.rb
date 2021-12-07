require 'capybara/rspec'
require_relative '../../app'
Capybara.app = BookmarkManager

feature 'visiting Bookmarks' do
  scenario 'shows bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.makersacademy.com');")
    connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.destroyallsoftware.com');")
    connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.google.com');")

    visit('/bookmarks')

    expect(page).to have_content("http://www.makersacademy.com").once
    expect(page).to have_content("http://www.destroyallsoftware.com").once
    expect(page).to have_content("http://www.google.com").once
  end
end
