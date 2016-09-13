require 'get_process_start_time'
require 'optparse'

class GetProcessStartTime
  class CLI
    def parse_options(argv = ARGV)
      op = OptionParser.new

      self.class.module_eval do
        define_method(:usage) do |msg = nil|
          puts op.to_s
          puts "error: #{msg}" if msg
          exit 1
        end
      end

      opts = {}
      op.banner += ' PID'
      begin
        args = op.parse(argv)
      rescue OptionParser::InvalidOption => e
        usage e.message
      end

      if args.size < 1
        usage 'PID argument is required'
      end

      [opts, args]
    end

    def run
      opts, args = parse_options
      pid = args.first.to_i
      puts GetProcessStartTime.start_time(pid).to_f
    end
  end
end
