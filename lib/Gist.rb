class Gist
  attr_reader :id, :public_attribute, :url, :description, :files, :created_at, :user_name
  def initialize(attributes)
    @id = attributes['id']
    @public_attribute = attributes['public']
    @url = attributes['url']
    @description = attributes['description']
    @files = attributes['files'].keys.join(', ')
    @created_at = Time.parse(attributes['created_at'])
    @user_name = attributes['user']['login']
  end

  def self.create(options)
    post_response = Faraday.post do |request|
      request.url 'https://api.github.com/gists'
      request.headers['Authorization'] = "Basic " + Base64.encode64("#{$github_username}:#{$github_password}")
      request.body = options.to_json
    end
  end

  def self.delete(id)
    delete_response = Faraday.delete do |request| 
      request.url "https://api.github.com/gists/#{id}"
      request.headers['Authorization'] = "Basic " + Base64.encode64("#{$github_username}:#{$github_password}")
    end
  end

  def self.all
    list_response = Faraday.get do |request|
      request.url "https://api.github.com/gists"
      request.headers['Authorization'] = "Basic " + Base64.encode64("#{$github_username}:#{$github_password}")
    end
    JSON.parse(list_response.body)
  end

  def self.view(id)
    get_response = Faraday.get do |request|
      request.url "https://api.github.com/gists/#{id}"
      request.headers['Authorization'] = "Basic " + Base64.encode64("#{$github_username}:#{$github_password}")
    end
    Gist.new(JSON.parse(get_response.body))
  end

  # def files
  #   get_response = Faraday.get do |request|
  #     request.url "https://api.github.com/gists/#{id}"
  #     request.headers['Authorization'] = "Basic " + Base64.encode64("#{$github_username}:#{$github_password}")
  #   end
  #   gist = JSON.parse(get_response.body)
  #   gist['file']['ring.erl']['filename']
  # end

def public
   gist['public']

end

end