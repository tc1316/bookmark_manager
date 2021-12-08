# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @bookmark = Bookmark.all
    erb :list_of_bookmarks
  end

  post '/url' do
    Bookmark.create(params[:url], params[:title])
    redirect '/bookmarks'
  end

  run! if app_file == $PROGRAM_NAME
end
