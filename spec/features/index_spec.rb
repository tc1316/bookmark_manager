require 'capybara/rspec'
require_relative '../../app'
Capybara.app = BookmarkManager

feature 'visiting BookmarkManager' do
  before do
    visit('/')
  end

  scenario 'shows the index page first' do
    expect(page).to have_content('Bookmark Manager')
  end
end
