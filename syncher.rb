require 'world_bank'

CURRENT_INDICATOR = 'SP.POP.TOTL'
MAXIMUM_BUFFER_SIZE = 500
DEFAULT_INITIAL_BUFFER_SIZE = 50


def do_it
  puts "about to make wb api call..."
  query = WorldBank::Data.country('all').indicator(CURRENT_INDICATOR)
  data = query.fetch
  available_data_count = query.total
  puts "There are #{available_data_count} pieces of data available"
  if available_data_count > MAXIMUM_BUFFER_SIZE
    execute_multiple_queries(query)
  elsif available_data_count > DEFAULT_INITIAL_BUFFER_SIZE
    fetch_all_data
  else
    complete
  end
end

def execute_multiple_queries(query)
  puts "running query sequence..."
  scheduler = QueryScheduler.new(query)
  puts "#{scheduler.total_queries} scheduled..."
  query.per_page(MAXIMUM_BUFFER_SIZE)
  results = []
  scheduler.total_queries.times do |i|
    puts "beginning query #{i}"
    res = query.page(i+1).fetch
    puts "here are resss #{res}"
    results << res
    # puts "query #{1} finished, results now contains #{results.size} elements"
  end
end

def fetch_all_data
  puts "fetching all data..."
end

def complete
  puts "Data fetch complete."
end

class QueryScheduler
  attr_reader :query
  
  def initialize(query)
    @query = query
  end
  
  def total_queries
    (query.total / MAXIMUM_BUFFER_SIZE.to_f).ceil
  end
end


do_it