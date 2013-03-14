require 'spec_helper'

describe Ty do
  context 'associations' do
    it {should belong_to(:category)}
    it {should belong_to(:expense)}
  end
end