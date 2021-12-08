require 'pg'

class Bookmark

  def self.all
    if ENV['CUSTOM_ENV_TYPE'] == 'test'
      con = PG.connect(dbname: 'bookmark_manager_test') 
    else 
      con = PG.connect(dbname: 'bookmark_manager') 
    end

    rs = con.exec('SELECT * FROM bookmarks')
    rs.map { |bookmark| bookmark['url'] }  
    #Returns array of values from url as key
  end 

  def self.create(url)
    if ENV['CUSTOM_ENV_TYPE'] == 'test'
      con = PG.connect(dbname: 'bookmark_manager_test') 
    else 
      con = PG.connect(dbname: 'bookmark_manager') 
    end

    rs = con.exec("INSERT INTO bookmarks (url) VALUES ('#{url}');")
  end


end

