class Category < ActiveRecord::Base
  has_many :expenses
  # validates :name, :presence => true
  # validates :amount
end
