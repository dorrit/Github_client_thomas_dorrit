class Gist
  def self.create(options)
    post_response = Faraday.post do |request|
      request.url 'https://api.github.com/gists'
      request.headers['Authorization'] = "Basic " + Base64.encode64("#{@github_username}:#{@github_password}")
      request.body = options.to_json
    end
  end

  def self.delete(id)
    delete_response = Faraday.delete {|request| request.url "https://api.github.com/gists/#{id}"}
  end

  def self.list
    list_response = Faraday.get {|request| request.url "https://api.github.com/gists"}
  end

  def self.view(id)
    get_request = Faraday.get {|request| request.url "https://api.github.com/gists/#{id}"}
  end
end