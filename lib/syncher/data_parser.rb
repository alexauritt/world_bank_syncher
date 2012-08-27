require 'world_bank'

module Syncher
  class DataParser
    def self.parse(data_collection)
      results = {:id => data_collection.first.id }
      data_collection.each do |datum|
        results[datum.others['country']['value']] ||= []
        results[datum.others['country']['value']] << { :year => datum.date, :value => datum.value }
      end
      results
    end
  end
end