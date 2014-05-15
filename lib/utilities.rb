pub_config = (YAML.load(ERB.new(File.read(File.expand_path('../../config.yml', __FILE__))).result) rescue {}) || {}
sec_config = (YAML.load(ERB.new(File.read(File.expand_path('../../sec_config.yml', __FILE__))).result) rescue {}) || {}
AppConfig = Konf.new(pub_config.merge(sec_config))

class Utilities

  attr_reader :api

  def initialize
    @api = FacebookApi.new( AppConfig.oauth_access_token )
    @iterations_done = 0
    @start_time = Time.now
    @exit_requested = false
    start_program
  end

  def start_program
    Kernel.trap( "INT" ) { @exit_requested = true }
    puts "Program started - press CTRL+C to exit."
  end

  def finish_program
    remove_instance_variable(:@api)
    puts "Program finished."
  end

  def sleep_one_sec
    AppConfig.sleep_time.times { sleep 1 if !@exit_requested }
  end

  def exit_requested?
    @exit_requested
  end

  def iterations_condition
    @iterations_done < AppConfig.max_iterations
  end

  def result_condition task, result
    @api.method(task).call == result
  end

  def iteration_done
    @iterations_done += 1
  end

  def time_condition
    @start_time > Time.now - AppConfig.max_time
  end

  def after_task task_to_do, condition_type, task = nil, result = nil
    if condition_type == "result"
      @api.method(task_to_do).call if send("#{condition_type}_condition", task, result)
    else
      @api.method(task_to_do).call if method("#{condition_type}_condition").call
    end
  end
end
