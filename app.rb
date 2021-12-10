# frozen_string_literal: true
require 'sinatra/flash'
require 'uri'
require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/bookmark'
require_relative './spec/database_connection_setup'

class BookmarkManager < Sinatra::Base
  enable :method_override
  enable :sessions

  register Sinatra::Flash

  configure :development do
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
    flash[:notice] = 'Invalid URL!' unless Bookmark.create(params[:url], params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(params[:id])
    erb :edit
  end

  patch '/bookmarks/:id' do
    Bookmark.update(params[:id], params[:url], params[:title])
    redirect '/bookmarks'
  end

  run! if app_file == $PROGRAM_NAME
end
