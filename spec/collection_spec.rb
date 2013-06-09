require 'spec_helper'

class Kojn::Coin < Kojn::Model;end
class Kojn::Coins < Kojn::Collection;end

describe Kojn::Coins do
  let(:kojns) { Kojn::Coins.new }

  it 'should have a name representing the class his name but not modules' do
    kojns.name.should eq 'coin'
  end

  it 'module should reflect a singular form' do
    kojns.module.should eq "kojn/coin"
  end

  it 'should have a model' do
    kojns.model.should be Kojn::Coin
  end

  it 'should have an api end point' do
    kojns.path.should eq "/api/coins"
  end
end
