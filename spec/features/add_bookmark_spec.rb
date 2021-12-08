# frozen_string_literal: true

require 'capybara/rspec'
require_relative '../../app'
Capybara.app = BookmarkManager

feature 'add bookmark to BookmarkManager' do
  scenario 'can see new bookmark upon adding it' do
    PG.connect(dbname: 'bookmark_manager_test')
    visit('/bookmarks')
    fill_in('url', with: 'www.github.com')
    fill_in('title', with: 'Github')
    click_button('Submit')
    expect(page).to have_link('Github', href: 'www.github.com').once
  end
end
