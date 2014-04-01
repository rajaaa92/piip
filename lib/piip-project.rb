require 'rubygems'
require 'bundler/setup'
Bundler.require

require_relative "facebook_api"

puts "Program started."

# including config
pub_config = (YAML.load(ERB.new(File.read(File.expand_path('../../config.yml', __FILE__))).result) rescue {}) || {}
AppConfig = Konf.new(pub_config)


@api = FacebookApi.new( AppConfig.oauth_access_token )
@api.read( AppConfig.statuses_to_read_numer ) if AppConfig.reading_enabled
@api.post( AppConfig.text_to_write + " #{Time.now}" ) if AppConfig.writing_enabled


remove_instance_variable(:@api)

puts "Program finished."
