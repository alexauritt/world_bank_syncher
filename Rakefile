require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
require './lib/syncher'

task :test => :spec
task :default => :spec

task :queries do
  Syncher::SynchJob.new.do_it
end
