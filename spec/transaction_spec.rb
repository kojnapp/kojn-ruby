require 'spec_helper'

# Move this
def stub_http(response)
  require 'json'

  http = double('http')
  # TODO We need some real data here
  http.stub(:read_body).and_return(response.to_json)
  http.stub(:"use_ssl=")
  http.stub(:"verify_mode=")
  http.stub(:"request").and_return(http)

  ::Net::HTTP.stub!(:new).and_return(http)
end

describe Kojn::Invoice do
  before :each do
    stub_http({test: 'stuff'})
  end

  it 'should not fail' do
    Kojn::Net.get('/bullshit').read_body.should eq "{\"test\":\"stuff\"}"
  end
end
