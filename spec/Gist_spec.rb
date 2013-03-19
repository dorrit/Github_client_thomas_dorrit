require 'spec_helper'

describe Gist do 

  attributes = {'id' => '1234567',
              'public' => 'true',
              'url' => 'https://api.github.com/gists/5179083',
              'description' => 'nothing much',
              'files' => {'scrumptious.rb' => 'something'},
              'created_at' => '2013-03-17T01:07:10Z',
              'user' => {'login' => 'mumford'}
              }
 
  context '#initialize' do 
    it 'initializes an instance of Gist' do
      gist = Gist.new(attributes)
      gist.should be_an_instance_of Gist
    end
  end

  context 'attr_readers' do
    let(:attributes) {attributes}
    let(:gist) {Gist.new(attributes)}
    it 'should return the value for id' do
      gist.id.should eq '1234567'
    end

    it 'should return the value for public' do
      gist.public_attribute.should eq 'true'
    end

    it 'should return the value for url' do
      gist.url.should eq 'https://api.github.com/gists/5179083'
    end

    it 'should return the value for description' do
      gist.description.should eq 'nothing much'
    end

    it 'should return the names of the files' do
      gist.files.should eq 'scrumptious.rb'
    end

    it 'should return the creation date in an unreadable format' do
      gist.created_at.should eq Time.utc(2013, 03, 17, 1, 07, 10)
    end

    it 'should return the login name of the user who created the Gist' do
      gist.user_name.should eq 'mumford'
    end

  end

  context '.create' do 
    it 'POSTs a new Gist to the user\'s account' do 
      gist = {:public => 'true',
              :description => 'a test gist',
              :files => {'test_file.rb' => {:content => 'puts "hello world!!"'}}}
      stub = stub_request(:post, "https://#{$github_username}:#{$github_password}@api.github.com/gists").with(:body => gist.to_json)
      Gist.create(gist)
      stub.should have_been_requested
    end
  end

  context '.delete' do 
    it 'DELETEs a Gist from the user\'s account' do
      id = 5190084
      stub = stub_request(:delete, "https://#{$github_username}:#{$github_password}@api.github.com/gists/#{id}")
      Gist.delete(id)
      stub.should have_been_requested
    end
  end

  context '.all' do
    gist = [attributes]
    it 'GETs a list of all the user\'s Gists' do
      stub = stub_request(:get, "https://#{$github_username}:#{$github_password}@api.github.com/gists").to_return(:body => gist.to_json)
      Gist.all
      stub.should have_been_requested
    end 

    it 'returns an array of gist objects' do 
      stub = stub_request(:get, "https://#{$github_username}:#{$github_password}@api.github.com/gists").to_return(:body => gist.to_json)
      gists = Gist.all
      gists.first.should be_an_instance_of Gist
    end
  end

  context '.view' do 
    gist = attributes
    id = 123456

    it 'GETs a specific Gist' do
      stub = stub_request(:get, "https://#{$github_username}:#{$github_password}@api.github.com/gists/#{id}").to_return(:body => gist.to_json)
      Gist.view(id)
      stub.should have_been_requested
    end

    it 'should return a gist object' do 
      stub = stub_request(:get, "https://#{$github_username}:#{$github_password}@api.github.com/gists/#{id}").to_return(:body => gist.to_json)
      Gist.view(id).should be_an_instance_of Gist
    end
  end
end