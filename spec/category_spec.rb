require 'spec_helper'

describe Category do
  context 'associations' do
    it {should have_many(:expenses).through(:ties)}
    it {should have_many(:ties)}
  end

  context 'callbacks' do
    it 'converts the category name to uppercase' do
      original_name = 'books'
      category = FactoryGirl.create(:category, :name => original_name)
      category.name.should eq original_name.upcase
    end
  end
end