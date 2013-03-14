class Expense < ActiveRecord::Base
  has_many :ties
  has_many :categories, :through => :ties
  # validates :name, :presence => true
  # validates :name, :length => {:maximum => 25}
  before_save :downcase_name

  private

  def downcase_name
    self.name = self.name.downcase
  end
end