require 'spec_helper'

describe String do
  before :each do
  end

  it 'should be able to plularize' do
    lambda { "Test".pluralize }.should_not raise_error
  end

  it 'should pluralize' do
    "Kojn".pluralize.should eq "Kojns"
  end
end
