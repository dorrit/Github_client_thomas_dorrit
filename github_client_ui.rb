require 'faraday'
require 'json'

require 'base64'
require 'time'

require './lib/gist.rb'

$github_username = 'dorrit'
$github_password = 'carriagereturn1'

def welcome
  puts "\nWelcome to the Github command-line client."
  # puts "Enter your GitHub username:"
  # @github_username = gets.chomp
  # puts "Enter your GitHub password:"
  # @github_password = gets.chomp
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "\n      MAIN MENU"
    puts "\nWhat would you like to do?"
    puts "\nPress 'l' to list your Gists, 'c' to create a new Gist, 'v' to view a Gist, 'u' to update a Gist, or 'd' to delete a Gist."
    puts "Press 'e' to exit."

    case choice = gets.chomp
    when 'l'
      list
    when 'c'
      create
    when 'v'
      view
    when 'u'
      update
    when 'd'
      delete
    when 'e'
      exit
    else
      invalid
    end
  end
end

def create
  public_attribute = nil
  while public_attribute.nil?
    puts "\nWould you like this Gist to be public? Type 'y' or 'n'."
    public_attribute = gets.chomp
    case public_attribute
    when 'y'
      public_attribute = true
    when 'n'
      public_attribute = false
    else
      puts "That wasn't a valid choice."
    end
  end
  puts "Type a description for the Gist, or hit Enter for no description."
  description = gets.chomp
  puts "What would you like the name of the file in the Gist to be?"
  filename = gets.chomp
  puts "Now, type the content of the Gist:"
  content = gets.chomp
  files = {filename => {:content => content}}

  Gist.create(:public => public_attribute, :description => description, :files => files)
end

def list
  gists = Gist.all
  puts "\nHere is a list of all of your Gists"
  puts "\n ID# \tPUBLIC \t  CREATED AT    \t    HTML URL"
  gists.each do |gist|
  puts "#{gist['id']}\t#{gist['public']}\t#{gist['created_at']}\t#{gist['html_url']}"
  end
end

def update
end

def view
  list
  puts "\nWhich ID number do you want to view?"
  id = gets.chomp
  gist = Gist.view(id)
  puts "ID: #{id}"
  puts "Public: #{gist.public_attribute}"
  puts "Created at: #{gist.created_at.strftime("%A, %B %e, %Y, %l:%M%P")}"
  puts "URL: #{gist.url}"
  puts "Files: #{gist.files}"
  puts "User Name: #{gist.user_name}"
  puts "Description: #{gist.description}"
end

def delete
  list
  puts "\nWhich ID number do you want to delete?"
  id_numb = gets.chomp
  Gist.delete(id_numb)
  puts "You just deleted this file"
end

welcome