require 'pg'
require 'rspec'
require 'active_record'
require 'shoulda-matchers'
require 'factory_girl'
require './spec/factories'
require './lib/expense'
require './lib/category'
require './lib/tie'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Expense.all.each {|expense| expense.destroy}
    Category.all.each {|category| category.destroy}
    Ty.all.each {|tie| tie.destroy}
  end
end