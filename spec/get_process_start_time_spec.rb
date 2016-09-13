require "spec_helper"

describe GetProcessStartTime do
  it "#time_of_boot" do
    expect(GetProcessStartTime.time_of_boot).not_to be_nil
  end

  it "#clock_tick" do
    expect(GetProcessStartTime.clock_tick).not_to be_nil

    require 'etc'
    if defined?(Etc::SC_CLK_TCK)
      expect(GetProcessStartTime.clock_tick).to eq(Etc.sysconf(Etc::SC_CLK_TCK))
    end
  end

  it '#start_time' do
    expect(GetProcessStartTime.start_time($$)).not_to be_nil
  end
end
