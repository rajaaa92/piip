class FacebookApi

  def initialize(token, log = true)
    put_log("Logging in started")
    @api = Koala::Facebook::API.new(token)
    put_log("Logging in finished")
  end

  def post(text = nil, log = true)
    text ||= AppConfig.text_to_write + " #{Time.now}"
    put_log("Posting started") if log
    resp = @api.put_wall_post(text) rescue {id: nil}
    put_log("Posting finished", "Post id: #{resp["id"]}") if log
    return resp["id"]
  end

  def echo
    puts "echo"
  end

  def read(posts_number = nil, log = true)
    posts_number ||= AppConfig.statuses_to_read_numer
    put_log("Reading started") if log
    statuses = @api.get_object("/me/statuses", "fields"=>"message", "limit" => posts_number) rescue []
    put_log("Reading finished", "Read statuses: #{statuses.count}") if log
    return statuses.count
  end

  def put_log(label, body = nil)
    time = Time.now
    body = "<#{body}>" if body
    puts "#{label}: #{time.strftime('%H:%M:%S.%3N')} #{body}"
  end

end
