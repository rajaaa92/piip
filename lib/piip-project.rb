require 'rubygems'
require 'bundler/setup'
Bundler.require

require_relative "facebook_api"
require_relative "utilities"

Utilities.start_program

@api = FacebookApi.new( AppConfig.oauth_access_token )
while !Utilities.exit_requested? do
  @api.read( AppConfig.statuses_to_read_numer ) if AppConfig.reading_enabled
  @api.post( AppConfig.text_to_write + " #{Time.now}" ) if AppConfig.writing_enabled
  Utilities.sleep_one_sec
end

remove_instance_variable(:@api)

Utilities.finish_program

