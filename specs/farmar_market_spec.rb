require_relative 'spec_helper'

describe FarMar::Market do

  describe "#all" do
    before do
      @all_markets = FarMar::Market.all
    end

    it "Returns an array of Market objects" do
      @all_markets.must_be_instance_of Array
      @all_markets.first.must_be_instance_of FarMar::Market
    end

    it "Returns all market objects, including the first" do
      @all_markets.first.name.must_equal "People's Co-op Farmers Market"
    end

    it "Returns all market objects, including the last" do
      @all_markets.last.name.must_equal "Montefiore Medical Center Farmers Market_Thursday"
    end
  end

  describe "#find" do
    it "Finds a market that exists" do
      FarMar::Market.find(345).name.must_equal "Downtown Daytona Beach Farmers Market"
    end

    it "Raises an argument error if the market does not exist" do
      proc {
        FarMar::Market.find("BOGUS")
      }.must_raise ArgumentError
    end
  end

end
