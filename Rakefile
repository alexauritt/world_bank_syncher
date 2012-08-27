require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
require './lib/syncher'

task :test => :spec
task :default => :spec

task :queries do
  puts Syncher::Job.new('SP.POP.TOTL').fetch ? "QUERY SUCCESSFUL!" : "QUERY FAILURE!!!!!!!!!!"
end
