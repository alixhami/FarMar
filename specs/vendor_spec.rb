require_relative 'spec_helper'

describe FarMar::Vendor do

  describe "Class methods" do
    describe "self.all" do
      before do
        @all_vendors = FarMar::Vendor.all
      end

      it "Returns an array of Vendor objects" do
        @all_vendors.must_be_instance_of Array
        @all_vendors.first.must_be_instance_of FarMar::Vendor
      end

      it "Returns all vendor objects, including the first" do
        @all_vendors.first.name.must_equal "Feil-Farrell"
      end

      it "Returns all vendor objects, including the last" do
        @all_vendors.last.name.must_equal "Mann-Lueilwitz"
      end
    end

    describe "self.find" do
      it "Finds a vendor that exists" do
        FarMar::Vendor.find(1120).name.must_equal "Walker-Corwin"
      end

      it "Raises an argument error if the vendor does not exist" do
        proc {
          FarMar::Vendor.find("BOGUS")
        }.must_raise ArgumentError
      end
    end

    describe "self.by_market" do
      before do
        @target_vendors = FarMar::Vendor.by_market(495)
      end

      it "Returns an array of Vendor objects" do
        @target_vendors.must_be_instance_of Array
        @target_vendors.first.must_be_instance_of FarMar::Vendor
      end

      it "Returns the correct associated vendor numbers" do
        @target_vendors.map { |vendor| vendor.id }.must_equal [2662, 2663, 2664, 2665, 2666]
      end
    end
  end

  describe "Instance Methods" do
    before do
      @vendor = FarMar::Vendor.new(id: 1, name: "Feil-Farrell", employee_count: 8, market_id: 1)
    end

    describe "#market" do
      it "Returns the Market object associated with a Vendor instance" do
        @vendor.market.must_be_instance_of FarMar::Market
        target_market = @vendor.market

        target_market.id.must_equal 1
        target_market.name.must_equal "People's Co-op Farmers Market"
      end
    end

    describe "#products" do
      before do
        @products = @vendor.products
      end

      it "Returns an array of Product objects" do
        @products.must_be_instance_of Array
        @products.first.must_be_instance_of FarMar::Product
      end

      it "Returns the correct products associated with the vendor" do
        @products.map { |product| product.name }.must_equal ["Dry Beets"]
      end
    end

    describe "#sales & #revenue" do
      before do
        @sales = @vendor.sales
        @sale_amounts = [92.90, 22.62, 95.88, 16.34, 44.40, 69.50, 40.95]
      end

      it "Returns an array of Sale objects" do
        @sales.must_be_instance_of Array
        @sales.first.must_be_instance_of FarMar::Sale
      end

      it "Returns the correct sales associated with the vendor" do
        @sales.map { |sale| sale.amount }.must_equal @sale_amounts
      end

      it "Returns the correct revenue amount" do
        @vendor.revenue.must_equal @sale_amounts.reduce(:+)
      end
    end

  end

end
