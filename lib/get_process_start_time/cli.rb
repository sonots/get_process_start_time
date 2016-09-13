require 'get_process_start_time'
require 'optparse'

class GetProcessStartTime
  class CLI
    def parse_options(argv = ARGV)
      self.class.module_eval do
        define_method(:usage) do |msg = nil|
          puts "Usage: get_process_start_time <PID>"
          puts "Or:    get_process_start_time test <PID> <COMPARTOR> <SECONDS>"
          puts ""
          puts "Get starting time of a process with unix timestamp"
          puts ""
          puts "  $ get_process_start_time <PID>"
          puts "  <unix timestamp>"
          puts ""
          puts "Test living duration of a process is less than (or greater than) a given seconds"
          puts ""
          puts "  $ get_process_start_time test_duration <PID> <COMPARTOR> <SECONDS>"
          puts "  $ echo $? # 0 or 1"
          puts ""
          puts "COMPARTOR: -lt (less than) or -gt (greater than)"
          if msg
            puts ""
            puts "ERROR: #{msg}"
          end
          exit 1
        end
      end

      begin
        case argv[0]
        when '-h', '--help'
          usage
        when 'test_duration'
          if argv.size < 4
            usage 'number of arguments must be 4'
          end
          @subcommand = :test_duration
          @pid = Integer(argv[1])
          @comparator = validate_comparator!(argv[2])
          @seconds = Float(argv[3])
        else
          if argv.size < 1
            usage 'number of arguments must be at least 1'
          end
          @subcommand = :show
          @pid = Integer(argv[0])
        end
      rescue => e
        usage e.message
      end
    end

    def run
      parse_options
      case @subcommand
      when :show
        show
      when :test_duration
        test_duration
      else
        assert(false)
      end
    end

    def show
      puts GetProcessStartTime.start_time(@pid).to_f
    end

    def test_duration
      start_time =  GetProcessStartTime.start_time(@pid).to_f
      living_duration = Time.now - start_time
      case @comparator
      when '-lt'
        exit 0 if living_duration.to_f < @seconds
      when '-gt'
        exit 0 if living_duration.to_f > @seconds
      end
      $stderr.puts "test_duration failed (living duration:#{living_duration.to_f} sec)"
      exit 1
    end

    def validate_comparator!(comparator)
      unless %w[-lt -gt].include?(comparator)
        raise "COMPARATOR must be -lt (less than) or -gt (greater than): #{comparator}"
      end
      comparator
    end
  end
end
