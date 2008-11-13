require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/public" do
  before(:each) do
    @response = request("/public")
  end
end