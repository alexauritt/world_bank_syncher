class QueryScheduler
  attr_reader :query
  
  def initialize(query)
    @query = query
    @results = []
  end
    
  def execute!
    total_queries.times do |i|
      res = query.page(i+1).fetch
      return nil if res.nil?
      results << res
    end
    results
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
