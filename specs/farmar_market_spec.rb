require_relative 'spec_helper'

describe FarMar::Market do

  describe "self.all" do
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

  describe "self.find" do
    it "Finds a market that exists" do
      FarMar::Market.find(345).name.must_equal "Downtown Daytona Beach Farmers Market"
    end

    it "Raises an argument error if the market does not exist" do
      proc {
        FarMar::Market.find("BOGUS")
      }.must_raise ArgumentError
    end
  end

  describe "#vendors" do
    it "Returns an array of all vendors associated with a market instance" do
      south_bend = FarMar::Market.find(495)

      sb_vendors = south_bend.vendors
      sb_vendors.length.must_equal 5
      sb_vendors.collect { |vendor| vendor.id }.must_equal [2662, 2663, 2664, 2665, 2666]
    end
  end
  
end
