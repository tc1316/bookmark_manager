# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base
  configure :development do
    enable :sessions, :method_override
    register Sinatra::Reloader
  end

  get '/' do
    redirect '/bookmarks'
  end

  get '/bookmarks' do
    @bookmark = Bookmark.all
    erb :bookmarks
  end

  post '/add' do
    Bookmark.create(params[:url], params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    p params
    Bookmark.delete(params[:id])
    redirect '/bookmarks'
  end

  run! if app_file == $PROGRAM_NAME
end
