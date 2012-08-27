require 'helper'

describe Syncher::SynchJob do
  context 'do_it' do
    it "should return nil if query shceduler returns nil" do
      WorldBank::DataQuery.any_instance.stub(:total).and_return(39)
      Syncher::QueryScheduler.any_instance.should_receive(:execute!).and_return(nil)
      job = Syncher::SynchJob.new
      job.do_it.should be_nil
    end

    it "should not return nil if query shceduler returns non nil value" do
      WorldBank::DataQuery.any_instance.stub(:total).and_return(39)
      Syncher::QueryScheduler.any_instance.should_receive(:execute!).and_return(:something)
      job = Syncher::SynchJob.new
      job.do_it.should_not be_nil
    end
  end
end
