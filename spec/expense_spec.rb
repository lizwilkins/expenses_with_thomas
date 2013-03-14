require 'spec_helper'

describe Expense do
  context 'associations' do
    it {should have_many(:ties)}
    it {should have_many(:categories).through(:ties)}
  end

  context 'callbacks' do
    it 'converts the expense name to lowercase' do
      original_name = 'Cook THE books'
      expense = FactoryGirl.create(:expense, :name => original_name)
      expense.name.should eq original_name.downcase
    end
  end
end

      # category_id = 1
      # expense_date = '2012/12/12'
      # amount = 33
      # expense = FactoryGirl.create(:expense, :name => original_name, :category_id => category_id, 
      #                              :expense_date => expense_date,:amount => amount)
