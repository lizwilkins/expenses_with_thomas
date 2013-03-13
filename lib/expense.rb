class Expense < ActiveRecord::Base
  belongs_to :category
  # validates :name, :presence => true
  # validates :name, :length => {:maximum => 25}
end