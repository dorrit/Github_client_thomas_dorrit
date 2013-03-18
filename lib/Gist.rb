class Gist
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
    get_request = Faraday.get do |request|
      request.url "https://api.github.com/gists/#{id}"
      request.headers['Authorization'] = "Basic " + Base64.encode64("#{$github_username}:#{$github_password}")
    end
  end
end