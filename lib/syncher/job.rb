require 'world_bank'

module Syncher
  class Job
    def do_it
      puts "about to make wb api call..."
      query = WorldBank::Data.country('all').indicator(Syncher::CURRENT_INDICATOR)
      fetch_all_data query
    end

    private
    def fetch_all_data(query)
      scheduler = Syncher::QueryScheduler.new(query)
      query.per_page(Syncher::MAXIMUM_BUFFER_SIZE)
      results = scheduler.execute!
      if results.nil?
        # puts "no results returned"
        results
      else
        checksum = Digest::MD5.hexdigest Marshal.dump(results)
        # puts "results returned, with checksum: #{checksum}"
        [results, checksum]
      end
    end

    def complete
      puts "Data fetch complete."
    end
  end
end