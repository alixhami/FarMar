require_relative 'spec_helper'

describe FarMar::Sale do

  describe "self.all" do
    before do
      @all_sales = FarMar::Sale.all
    end

    it "Returns an array of Sale objects" do
      @all_sales.must_be_instance_of Array
      @all_sales.first.must_be_instance_of FarMar::Sale
    end

    it "Returns all sale objects, including the first" do
      @all_sales.first.amount.must_equal 92.90
    end

    it "Returns all sale objects, including the last" do
      @all_sales.last.amount.must_equal 89.23
    end
  end

  describe "self.find" do
    it "Finds a sale that exists" do
      FarMar::Sale.find(9868).amount.must_equal 70.94
    end

    it "Raises an argument error if the sale does not exist" do
      proc {
        FarMar::Sale.find("BOGUS")
      }.must_raise ArgumentError
    end
  end

end
