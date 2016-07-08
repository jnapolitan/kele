require 'httparty'
require 'json'
require 'roadmap'

class Kele
  include HTTParty
  include JSON
  include Roadmap

  def initialize(email, password)
    @api_url = 'https://www.bloc.io/api/v1/'
    @email = email
    @password = password

    get_auth_token
  end

  def get_auth_token
    @options = { query: {email: @email, password: @password} }
    response = HTTParty.post("#{@api_url}/sessions", @options)
    @auth_token = response["auth_token"]
    puts 'ERROR: INVALID CREDENTIALS' if @auth_token == nil
  end

  def get_me
    response = self.class.get("#{@api_url}/users/me", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    @mentor_id = mentor_id
    response = self.class.get("#{@api_url}/mentors/#{@mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_messages
    response = self.class.get("#{@api_url}/message_threads/", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end
end
