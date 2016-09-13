require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rake/extensiontask"

Rake::ExtensionTask.new('get_process_start_time') do |ext|
    ext.lib_dir = 'lib/get_process_start_time'
end

RSpec::Core::RakeTask.new(:spec)

task :default => [:compile, :spec]
