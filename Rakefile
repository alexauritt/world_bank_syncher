require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
require './lib/syncher'

task :test => :spec
task :default => :spec

task :queries do
  puts Syncher::Job.new.do_it ? "QUERY SUCCESSFUL!" : "QUERY FAILURE!!!!!!!!!!"
end
