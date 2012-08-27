module Syncher
  class QueryScheduler
    attr_reader :query
  
    def initialize(query)
      @query = query
      @results = []
    end
    
    def execute!
      begin
        total_queries.times do |i|
          puts "About to execute query #{i+1}"
          res = query.page(i+1).fetch
          puts "query #{i+1} returned "
          return nil if res.nil?
          results << res
        end
        results
      rescue
        nil
      end
    end
  
    private
    def total_queries
      query.fetch unless query.total
      (query.total / Syncher::MAXIMUM_BUFFER_SIZE.to_f).ceil
    end

    def results=(results)
      @results = results
    end
  
    def results
      @results
    end
  end  
end
