require 'pg'
require 'active_record'

require '../lib/expense'
require '../lib/category'
require '../lib/tie.rb'

require './expense_menu_ui.rb'
require './category_menu_ui.rb'
require './REPORTS_ui.rb'


database_configurations = YAML::load(File.open('../db/config.yml'))
development_configuation = database_configurations["development"]
ActiveRecord::Base.establish_connection(development_configuation)

def input_error
  puts "FAIL! Try again!"
end

def input_error_for(valid_inputs)
  puts "Invalid entry."
  puts "Valid entries were: #{valid_inputs.each {|input| input.capitalize}.join(', ')}."
end

def empty_expense_list
  puts "No expenses were found."
end