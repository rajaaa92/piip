pub_config = (YAML.load(ERB.new(File.read(File.expand_path('../../config.yml', __FILE__))).result) rescue {}) || {}
AppConfig = Konf.new(pub_config)

class Utilities

  @@exit_requested = false

  class << self

    def start_program
      Kernel.trap( "INT" ) { @@exit_requested = true }
      puts "Program started - press CTRL+C to exit."
    end

    def finish_program
      puts "Program finished."
    end

    def sleep_one_sec
      AppConfig.sleep_time.times { sleep 1 if !@@exit_requested }
    end

    def exit_requested?
      @@exit_requested
    end

  end

end
