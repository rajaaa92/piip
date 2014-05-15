require 'rubygems'
require 'bundler/setup'
Bundler.require

require_relative "facebook_api"
require_relative "utilities"

utilities = Utilities.new

while !utilities.exit_requested? && utilities.iterations_condition  do
  utilities.api.read if AppConfig.reading_enabled
  utilities.api.post if AppConfig.writing_enabled
  # utilities.after_task("echo", "time")
  # utilities.after_task("echo", "result", "read", 4)
  utilities.sleep_one_sec
  utilities.iteration_done
end

utilities.finish_program
