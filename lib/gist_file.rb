class GistFile
  attr_reader :size, :file_name, :raw_url

  def initialize(attributes)
    @size = attributes['size']
    @file_name = attributes['filename']
    @raw_url = attributes['raw_url']
  end


end

    # files = {'file1.txt' => {'content' => 'updated file contents'},
    #          'old_name.txt' => {'filename' => 'new_name.txt',
    #                             'content' => 'modified contents'},
    #           'new_file.txt' => {'content' => 'a new file'}}


              #create file objects, initializing

              #update file objects when we are updating the gist



    # "files": {
    # "ring.erl": {
    #   "size": 932,
    #   "filename": "ring.erl",
    #   "raw_url": "https://gist.github.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl"
    # }