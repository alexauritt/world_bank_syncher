require 'world_bank'
require 'syncher/query_scheduler'

CURRENT_INDICATOR = 'SP.POP.TOTL'

module Syncher
  CURRENT_INDICATOR = 'SP.POP.TOTL'
  MAXIMUM_BUFFER_SIZE = 500
  DEFAULT_INITIAL_BUFFER_SIZE = 50  
end


def do_it
  puts "about to make wb api call..."
  query = WorldBank::Data.country('all').indicator(CURRENT_INDICATOR)
  data = query.fetch
  available_data_count = query.total
  puts "There are #{available_data_count} pieces of data available"
  if available_data_count > Syncher::MAXIMUM_BUFFER_SIZE
    execute_multiple_queries(query)
  elsif available_data_count > Syncher::DEFAULT_INITIAL_BUFFER_SIZE
    fetch_all_data
  else
    complete
  end
end

def execute_multiple_queries(query)
  scheduler = QueryScheduler.new(query)
  query.per_page(Syncher::MAXIMUM_BUFFER_SIZE)
  results = scheduler.execute!
end

def fetch_all_data
  puts "fetching all data..."
end

def complete
  puts "Data fetch complete."
end


# do_it