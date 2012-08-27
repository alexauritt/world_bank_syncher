require 'world_bank'

module Syncher
  class Job
    attr_reader :indicator_string, :results, :checksum
    
    def initialize(indicator_string)
      @indicator_string = indicator_string
      @results = nil
      @checksum = nil
    end
    
    def fetch
      puts "about to make wb api call..."
      query = WorldBank::Data.country('all').indicator(indicator_string)
      fetch_all_data query
    end

    private
    def fetch_all_data(query)
      scheduler = Syncher::QueryScheduler.new(query)
      query.per_page(Syncher::MAXIMUM_BUFFER_SIZE)
      @results = scheduler.execute!
      if results.nil?
        @results
      else
        @checksum = Digest::MD5.hexdigest Marshal.dump(@results)
        {:results => @results, :checksum => @checksum}
      end
    end
  end
end