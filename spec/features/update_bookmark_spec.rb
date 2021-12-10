require 'capybara/rspec'
require_relative '../../app'
Capybara.app = BookmarkManager

feature 'update existing bookmarks in Bookmark manager' do
  scenario 'can see a bookmark get updated' do
    bookmark = Bookmark.create('https://github.com/', 'Github')
    visit('/bookmarks')

    expect(page).to have_link('Github', href: 'https://github.com/')

    first('.bookmark').click_button('Edit')
    expect(current_path).to eq "/bookmarks/#{bookmark.id}/edit"

    fill_in('url', with: 'https://www.facebook.com/')
    fill_in('title', with: 'Facebook')
    click_button('Save')

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Github', href: 'https://github.com/')
    expect(page).to have_link('Facebook', href: 'https://www.facebook.com/').once
  end
end
