require 'spec_helper'

describe Expense do
  context 'associations' do
    it {should belong_to :category}
  end
end