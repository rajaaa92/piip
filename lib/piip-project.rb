require 'rubygems'
require 'bundler/setup'
Bundler.require

require_relative "facebook_api"

puts "Started."

pub_config = (YAML.load(ERB.new(File.read(File.expand_path('../../config.yml', __FILE__))).result) rescue {}) || {}
AppConfig = Konf.new(pub_config)

@api = FacebookApi.new(AppConfig.oauth_access_token)

@api.post("I am writing on my wall again again wow serio niee!")

remove_instance_variable(:@api)

puts "Finished."
