require 'httparty'

class Kele
  include HTTParty

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
end
