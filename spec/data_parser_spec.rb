require 'helper'

describe Syncher::DataParser do
  let(:indicator_id) { 'DJ.JIE.JIDL' }
  let(:data) { [mock_data(:country => 'Mexico', :year => 1990, :id => indicator_id, :value => 234)] }

  it "should parse data and return expected hash structure" do
    actual = Syncher::DataParser.parse data
    actual.should eq({:id => indicator_id, 'Mexico' => [{:year => 1990, :value => 234}]})
  end

  it "should mock data properly" do
    f = data.first
    f.value.should eq(234)
    f.id.should eq('DJ.JIE.JIDL')
    f.date.should eq(1990)
    f.others['country']['value'].should eq('Mexico')
  end
  
  def mock_data(attr)
    mockal = Object.new
    mockal.stub(:value).and_return(attr[:value])
    mockal.stub(:id).and_return(attr[:id])
    mockal.stub(:date).and_return(attr[:year])

    country_data = {'country' => {'value' => attr[:country]}}
    mockal.stub(:others).and_return(country_data)
    mockal
  end
end
