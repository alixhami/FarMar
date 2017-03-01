require_relative 'spec_helper'

describe FarMar::Product do

  describe "#all" do
    before do
      @all_products = FarMar::Product.all
    end

    it "Returns an array of Product objects" do
      @all_products.must_be_instance_of Array
      @all_products.first.must_be_instance_of FarMar::Product
    end

    it "Returns all product objects, including the first" do
      @all_products.first.name.must_equal "Dry Beets"
    end

    it "Returns all product objects, including the last" do
      @all_products.last.name.must_equal "Cruel Beef"
    end
  end

  describe "#find" do
    it "Finds a product that exists" do
      FarMar::Product.find(4160).name.must_equal "Prickly Beef"
    end

    it "Raises an argument error if the product does not exist" do
      proc {
        FarMar::Product.find("BOGUS")
      }.must_raise ArgumentError
    end
  end

end
