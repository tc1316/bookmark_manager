require 'capybara/rspec'
require_relative '../../app'
Capybara.app = BookmarkManager

feature 'validates bookmark urls' do
  scenario 'raises an error when adding or editing invalid urls' do
    visit('/bookmarks')
    fill_in('url', with: 'ww.github.com')
    fill_in('title', with: 'Github')
    click_button('Add')
    expect(page).to have_content("Invalid URL!")
    expect(page).not_to have_link('Github', href: 'www.github.com').once
  end
end