# frozen_string_literal: true

require 'capybara/rspec'
require_relative '../../app'
Capybara.app = BookmarkManager

feature 'visiting BookmarkManager' do
  before do
    visit('/')
  end

  scenario 'auto redirects to the bookmark page' do
    expect(page).to have_content('Bookmarks')
  end
end
