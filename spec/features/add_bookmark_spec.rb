# frozen_string_literal: true

require 'capybara/rspec'
require_relative '../../app'
Capybara.app = BookmarkManager

feature 'add bookmark to BookmarkManager' do
  scenario 'can see new bookmark upon adding it' do
    visit('/bookmarks')
    fill_in('url', with: 'https://www.github.com')
    fill_in('title', with: 'Github')
    click_button('Add')
    expect(page).to have_link('Github', href: 'https://www.github.com').once
  end
end
