require 'bookmark'

describe Bookmark do
  let(:bookmark) { described_class }

  context '#all' 
  it 'returns an array of bookmarks' do
    expect(bookmark.all).to match_array(["http://www.makersacademy.com/","http://www.destroyallsoftware.com","http://www.google.com/"])
  end 
end