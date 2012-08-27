module Syncher
  class SynchJob
    def do_it
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

    private
    def fetch_all_data(query)
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

    def complete
      puts "Data fetch complete."
    end
  end
end