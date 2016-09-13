require "get_process_start_time/version"
require "get_process_start_time/get_process_start_time" # clock_tick
require 'etc'

class GetProcessStartTime
  # @return [Time]
  def self.start_time(pid)
    stats = File.read("/proc/#{pid}/stat").chomp.split(/\s+/)
    convert_into_start_time(stats[21].to_f)
  end

  # @return [Time]
  def self.time_of_boot
    return @time_of_boot if @time_of_boot
    seconds_since_boot = File.read('/proc/uptime').split(/\s+/).first.to_f
    @time_of_boot = Time.now - seconds_since_boot
  end

  # @return [Time]
  def self.convert_into_start_time(start_time_jiffies)
    time_of_boot + (start_time_jiffies / clock_tick)
  end
end
