require 'spec_helper'

describe Gist do 
  context '.create' do 
    it 'POSTs a new Gist to the user\'s account' do 
      gist = {:public => 'true',
              :description => 'a test gist',
              :files => {'test_file.rb' => {:content => 'puts "hello world!!"'}}}

      stub = stub_request(:post, "https://api.github.com/gists").with(:body => gist.to_json)

      Gist.create(gist)
      stub.should have_been_requested
    end
  end

  context '.delete' do 
    it 'DELETEs a Gist from the user\'s account' do
      id = 123456
      stub = stub_request(:delete, "https://api.github.com/gists/#{id}")
      Gist.delete(id)
      stub.should have_been_requested
    end
  end

  context '.list' do
    it 'GETs a list of all the user\'s Gists' do
      stub = stub_request(:get, "https://api.github.com/gists")
      Gist.list
      stub.should have_been_requested
    end 
  end

  context '.view' do 
    it 'GETs a specific Gist' do
      id = 123456
      stub = stub_request(:get, "https://api.github.com/gists/#{id}")
      Gist.view(id)
      stub.should have_been_requested
    end
  end
end
