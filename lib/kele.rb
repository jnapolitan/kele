class Kele
  include HTTParty

  def initalize(email, password)
    @api_url = 'https://www.bloc.io/api/v1/'
    @auth_token = auth_token
    @email = email
    @password = password
  end

  def get_auth_token
    @options = { query: {email: @email, password: @password} }
    HTTParty.post("#{@api_url}/sessions", @options)
  end
end
