require_relative 'spec_helper'

describe FarMar::Product do

  describe "Class Methods" do

    describe "self.all" do
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

    describe "self.find" do
      it "Finds a product that exists" do
        FarMar::Product.find(4160).name.must_equal "Prickly Beef"
      end

      it "Raises an argument error if the product does not exist" do
        proc {
          FarMar::Product.find("BOGUS")
        }.must_raise ArgumentError
      end
    end

    describe "self.by_vendor" do
      before do
        @vendor_products = FarMar::Product.by_vendor(2)
        @product_names = ["Fierce Greens", "Heavy Chicken"]
      end

      it "Returns an Array of Vendor objects" do
        @vendor_products.must_be_instance_of Array
        @vendor_products.first.must_be_instance_of FarMar::Product
      end

      it "Returns all products associated with a vendor" do
        @vendor_products.map { |product| product.name }.must_equal @product_names
      end
    end

  end

  describe "Instance Methods" do
    before do
      @product = FarMar::Product.new(id: 2, name: "Fierce Greens", vendor_id: 2)
    end

    describe "#vendor" do
      it "Returns a Vendor object" do
        @product.vendor.must_be_instance_of FarMar::Vendor
      end

      it "Returns the associated vendor for a Product instance" do
        @product.vendor.name.must_equal "Hamill, Kilback and Pfeffer"
      end
    end

    describe "#sales & #number_of_sales" do
      before do
        @product_sales = @product.sales
      end

      it "Returns an array of Sale objects" do
        @product_sales.must_be_instance_of Array
        @product_sales.first.must_be_instance_of FarMar::Sale
      end

      it "Returns the sales associated with a Product instance" do
        @product_sales.map { |sale| sale.amount }.must_equal [57.27]
      end

      it "Returns the number of sales associated with a Product instance" do
        @product.number_of_sales.must_equal 1
      end
    end
  end
end
