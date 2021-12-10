require_relative './../lib/db_con'

if ENV['CUSTOM_ENV_TYPE'] == 'test'
  DatabaseConnection.setup('bookmark_manager_test')
else
  DatabaseConnection.setup('bookmark_manager')
end
