require 'helper'

describe Syncher::Job do
  let(:indicator_string) { 'SP.POP.TOTL' }
  context 'fetch' do
    it "should return nil if query shceduler returns nil" do
      WorldBank::DataQuery.any_instance.stub(:total).and_return(39)
      Syncher::QueryScheduler.any_instance.should_receive(:execute!).and_return(nil)
      job = Syncher::Job.new indicator_string
      job.fetch.should be_nil
    end

    it "should not return nil if query shceduler returns non nil value" do
      WorldBank::DataQuery.any_instance.stub(:total).and_return(39)
      Syncher::QueryScheduler.any_instance.should_receive(:execute!).and_return(:something)
      job = Syncher::Job.new indicator_string
      job.fetch.should_not be_nil
    end
    
    it "returns a hash if there are no errors" do
      WorldBank::DataQuery.any_instance.stub(:total).and_return(39)
      Syncher::QueryScheduler.any_instance.should_receive(:execute!).and_return(:something)

      job = Syncher::Job.new indicator_string
      job.fetch.should be_an_instance_of(Hash)
    end
    
    it "should receive same checksum if scheduler returns identical results" do
      WorldBank::DataQuery.any_instance.stub(:total).and_return(39)
      Syncher::QueryScheduler.any_instance.stub(:execute!).and_return(:something)

      job = Syncher::Job.new indicator_string
      first = job.fetch[:checksum]
      second = job.fetch[:checksum]
      first.should eq(second)
    end
    
    it "should return unique checksums given unique results" do
      scheduler1 = Object.new
      scheduler2 = Object.new
      scheduler1.stub(:execute!).and_return(:something_else)
      scheduler2.stub(:execute!).and_return(:something)
      
      WorldBank::DataQuery.any_instance.stub(:total).and_return(39)
      Syncher::QueryScheduler.should_receive(:new).twice.and_return(scheduler1, scheduler2)


      job = Syncher::Job.new indicator_string
      second_job = Syncher::Job.new indicator_string
      first = job.fetch[:checksum]
      second = second_job.fetch[:checksum]
      first.should_not eq(second)      
    end
  end
end
