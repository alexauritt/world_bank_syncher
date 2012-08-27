require 'world_bank'
require 'syncher/job'
require 'syncher/query_scheduler'
require 'syncher/data_parser'

module Syncher
  MAXIMUM_BUFFER_SIZE = 10000
  DEFAULT_INITIAL_BUFFER_SIZE = 50
end