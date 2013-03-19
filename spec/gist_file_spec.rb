require 'spec_helper'

describe GistFile do 

  attributes = {'size' => 932,
                'filename' => 'good_grief.rb',
                'raw_url' => 'https://gist.github.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/good_grief.rb'}

  context '#initialize' do 
    it 'initializes an instance of File' do 
      gist_file = GistFile.new(attributes)
      gist_file.should be_an_instance_of GistFile
    end
  end

  context '#attr_readers' do
    let(:attributes) {attributes}
    let(:gist_file) {GistFile.new(attributes)}
    
    it 'should return the value for size' do 
      gist_file.size.should eq 932
    end

    it 'should return the file_name' do
      gist_file.file_name.should eq 'good_grief.rb'
    end

    it 'should return the raw_url' do
      gist_file.raw_url.should eq 'https://gist.github.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/good_grief.rb'
    end
  end


end

