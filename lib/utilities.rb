pub_config = (YAML.load(ERB.new(File.read(File.expand_path('../../config.yml', __FILE__))).result) rescue {}) || {}
sec_config = (YAML.load(ERB.new(File.read(File.expand_path('../../sec_config.yml', __FILE__))).result) rescue {}) || {}
AppConfig = Konf.new(pub_config.merge(sec_config))

class Utilities

  def initialize
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

  def iteration_done
    @iterations_done += 1
  end

  def time_condition
    @start_time > Time.now - AppConfig.max_time
  end
end
