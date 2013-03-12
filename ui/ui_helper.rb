require 'pg'
require 'active_record'
require '../lib/expense'
require '../lib/category'
require './expense_menu_ui.rb'
require './category_menu_ui.rb'

database_configurations = YAML::load(File.open('../db/config.yml'))
development_configuation = database_configurations["development"]
ActiveRecord::Base.establish_connection(development_configuation)