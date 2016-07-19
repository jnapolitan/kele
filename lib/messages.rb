module Messages
  def get_messages(page='all')
    if page == 'all'
      response = self.class.get("#{@api_url}/message_threads/", headers: { "authorization" => @auth_token })
      count = response['count']
      @page_count = (count/10) + 1
      get_all_pages
    else
      response = self.class.get("#{@api_url}/message_threads/?page=#{page}", headers: { "authorization" => @auth_token })
      JSON.parse(response.body)
    end
  end

  def get_all_pages
    message_threads = []
    (1..@page_count).each do |i|
      response = self.class.get("#{@api_url}/message_threads/?page=#{i}", headers: { "authorization" => @auth_token })
      message_threads << response['items']
    end
    message_threads
  end

  # Alex id 946
  # My id 2316798

  def create_message(user_id, recipient_id, subject, stripped)
    self.class.post("#{@api_url}/messages", headers: { "authorization" => @auth_token })
  end
end
