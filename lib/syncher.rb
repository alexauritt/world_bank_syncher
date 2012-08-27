require 'world_bank'
require 'syncher/query_scheduler'

CURRENT_INDICATOR = 'SP.POP.TOTL'

module Syncher
  CURRENT_INDICATOR = 'SP.POP.TOTL'
  MAXIMUM_BUFFER_SIZE = 500
  DEFAULT_INITIAL_BUFFER_SIZE = 50
  class SynchJob
    def self.do_it
      puts "about to make wb api call..."
      query = WorldBank::Data.country('all').indicator(CURRENT_INDICATOR)
      data = query.fetch
      available_data_count = query.total
      puts "There are #{available_data_count} pieces of data available"
      if available_data_count > Syncher::DEFAULT_INITIAL_BUFFER_SIZE
        fetch_all_data(query)
      else
        complete
      end
    end

    def self.fetch_all_data(query)
      scheduler = Syncher::QueryScheduler.new(query)
      query.per_page(Syncher::MAXIMUM_BUFFER_SIZE)
      results = scheduler.execute!
      if results
        puts "results returned"
      else
        checksum = Digest::MD5.hexdigest Marshal.dump(results)
        puts "results returned, with checksum: #{checksum}"
      end
    end

    def self.complete
      puts "Data fetch complete."
    end
  end
end