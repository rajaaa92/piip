require 'rubygems'
require 'bundler/setup'
Bundler.require

require_relative "facebook_api"
require_relative "utilities"

utilities = Utilities.new

@api = FacebookApi.new( AppConfig.oauth_access_token )

while !utilities.exit_requested? && utilities.iterations_condition && utilities.time_condition do
  @api.read( AppConfig.statuses_to_read_numer ) if AppConfig.reading_enabled
  @api.post( AppConfig.text_to_write + " #{Time.now}" ) if AppConfig.writing_enabled
  utilities.sleep_one_sec
  utilities.iteration_done
end

remove_instance_variable(:@api)

utilities.finish_program
