require 'world_bank'
require 'syncher/synch_job'
require 'syncher/query_scheduler'

module Syncher
  CURRENT_INDICATOR = 'SP.POP.TOTL'
  MAXIMUM_BUFFER_SIZE = 500
  DEFAULT_INITIAL_BUFFER_SIZE = 50
end