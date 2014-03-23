class FacebookApi

  def initialize(token, log = true)
    put_log("Loggin in started")
    @graph = Koala::Facebook::API.new(token)
    put_log("Loggin in finished")
  end

  def post(text, log = true)
    put_log("Posting started") if log
    @graph.put_connections("me", "feed", :message => text)
    put_log("Posting finished") if log
  end

  def put_log(label)
    time = Time.now
    puts "#{label}: #{time.strftime('%H:%M:%S.%3N')}"
  end

end
