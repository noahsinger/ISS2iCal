# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

if ENV['RAILS_ENV'] == "production"
  ENV['GEM_PATH'] = '/home/noah/ruby/gems:/usr/lib/ruby/gems/1.8'
  ENV['GEM_HOME']='/home/noah/ruby/gems'
end

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

