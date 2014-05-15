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

  def read(posts_number = nil, log = true)
    posts_number ||= AppConfig.statuses_to_read_numer
    ids_to_str = AppConfig.ids_to_read rescue AppConfig.my_id
    ids = ids_to_str.split(',')
    put_log("Reading started") if log
    resp = @api.get_object("/statuses?ids=#{ids_to_str}", "fields"=>"message", "limit" => posts_number) rescue []
    statuses_count = 0
    ids.each { |id| statuses_count += resp[id]["statuses"]["data"].count rescue 0 }
    put_log("Reading finished", "Read statuses: #{statuses_count}") if log
    return statuses_count
  end

  def put_log(label, body = nil)
    time = Time.now
    body = "<#{body}>" if body
    puts "#{label}: #{time.strftime('%H:%M:%S.%3N')} #{body}"
  end

  def echo
    puts "echo"
  end

end
