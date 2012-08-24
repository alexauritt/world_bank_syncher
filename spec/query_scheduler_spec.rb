require 'helper'
require 'world_bank'

describe QueryScheduler do
  let(:query) { WorldBank::Data.country('all').indicator('SP.POP.TOTL') }
  let(:scheduler) { QueryScheduler.new(query) }
  it "should trigger query fetch" do
    query.stub(:total).and_return(23)
    query.should_receive(:fetch).at_least(:once)
    scheduler.execute!
  end
end
