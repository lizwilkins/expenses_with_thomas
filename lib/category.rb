class Category < ActiveRecord::Base
  has_many :ties
  has_many :expenses, :through => :ties
  # validates :name, :presence => true
  # validates :amount
  before_save :upcase_name

  private

  def upcase_name
    self.name = self.name.upcase
  end
end
