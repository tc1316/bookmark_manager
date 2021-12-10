# frozen_string_literal: true

require 'capybara/rspec'
require_relative '../../app'
Capybara.app = BookmarkManager

feature 'delete a bookmark from BookmarkManager' do
  scenario 'can no longer see bookmark displayed' do
    visit('/bookmarks')
    fill_in('url', with: 'www.github.com')
    fill_in('title', with: 'Github')
    click_button('Add')
    expect(current_path).to eq '/bookmarks'
    expect(page).to have_link('Github', href: 'www.github.com').once

    # Expects first instance of html bookmark class below to have delete
    first('.bookmark').click_button('Delete')
    expect(page).not_to have_link('Github', href: 'www.github.com')
    expect(current_path).to eq '/bookmarks'
  end
end
