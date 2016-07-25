module Messages
  def get_messages(page='all')
    if page == 'all'
      get_page_count
      get_all_pages
    else
      response = self.class.get(api_url_call(page), auth_header)
      JSON.parse(response.body)
    end
  end

  def get_all_pages
    message_threads = []
    (1..@page_count).each do |i|
      response = self.class.get(api_url_call(i), auth_header)
      message_threads << response['items']
    end
    message_threads
  end

  def api_url_call(page)
    "#{@api_url}/message_threads/?page=#{page}"
  end

  def create_message(subject, stripped, token = nil)
    @subject = subject.to_s
    @stripped = stripped.to_s
    @token = token.to_s if token != nil
    self.class.post("#{@api_url}/messages", create_message_options)
  end

  def auth_header
    { headers: { "authorization" => @auth_token } }
  end

  def create_message_options
    { body: { :'user_id' => 2316798, #My ID
              :'recipient_id' => 946, #Alex's ID
              :'token' => @token,
              :'subject' => @subject,
              :'stripped-text' => @stripped
            }.to_json,
      headers: { "Content-Type" => "application/json",
                 "authorization" => @auth_token
               }
    }
  end

  def get_page_count
    response = self.class.get("#{@api_url}/message_threads/", auth_header)
    @page_count = (response['count']/10) + 1
  end
end
