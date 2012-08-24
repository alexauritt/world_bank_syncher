require 'helper'
require 'world_bank'

describe QueryScheduler do
  let(:query) { WorldBank::Data.country('all').indicator('SP.POP.TOTL') }
  let(:scheduler) { QueryScheduler.new(query) }

  before do
    query.stub(:total).and_return(23)
  end
  
  it "should trigger query fetch" do
    query.should_receive(:fetch).at_least(:once)
    scheduler.execute!
  end

  it "should return nil if query fetch returns nil" do
    query.stub(:fetch).and_return(nil)
    scheduler.execute!.should be_nil
  end
end
