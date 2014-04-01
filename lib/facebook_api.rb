class FacebookApi

  def initialize(token, log = true)
    put_log("Logging in started")
    @api = Koala::Facebook::API.new(token)
    put_log("Logging in finished")
  end

  def post(text, log = true)
    put_log("Posting started") if log
    resp = @api.put_wall_post(text)
    put_log("Posting finished", "Post id: #{resp["id"]}") if log
  end

  def read(posts_number, log = true)
    put_log("Reading started") if log
    statuses = @api.get_object("/me/statuses", "fields"=>"message", "limit" => posts_number)
    put_log("Reading finished", "Read statuses: #{statuses.count}") if log
  end

  def put_log(label, body = nil)
    time = Time.now
    body = "<#{body}>" if body
    puts "#{label}: #{time.strftime('%H:%M:%S.%3N')} #{body}"
  end

end
