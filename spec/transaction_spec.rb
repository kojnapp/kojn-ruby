require 'spec_helper'

# Move this
def stub_http
  http = double('http')
  # TODO We need some real data here
  http.stub(:read_body).and_return("{'test': 1}")
  http.stub(:"use_ssl=")
  http.stub(:"verify_mode=")
  http.stub(:"request").and_return(http)

  ::Net::HTTP.stub!(:new).and_return(http)
end

describe Kojn::Tx do
  before :each do
    stub_http
  end

  it 'should not fail' do
    raise Kojn::Net.get('/bullshit').read_body.inspect
  end
end
