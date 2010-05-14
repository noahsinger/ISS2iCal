# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

admin = Role.find_by_name("Administrator") || Role.create( :name => 'Administrator' )
User.create( :username => 'admin', :password => 'gun51ing3R', :password_confirmation => 'gun51ing3R', :role => admin ) unless User.find_by_username( "admin" )
