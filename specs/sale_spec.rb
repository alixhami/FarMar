require_relative 'spec_helper'

describe FarMar::Sale do

  describe "Class Methods" do
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

    describe "self.between" do
      it "Returns a sale that occurred between two DateTimes" do
        begin_time = DateTime.parse("2013-11-06 09:01:00 -0800")
        end_time = DateTime.parse("2013-11-06 09:05:00 -0800")
        target_sales = FarMar::Sale.between(begin_time, end_time)

        target_sales.length.must_equal 6
        target_sales.map { |sale| sale.id }.sort.must_equal [4300, 4845, 6381, 7219, 9226, 10181]
      end
    end
  end

  describe "Instance Methods" do
    before do
      @sale = FarMar::Sale.new(id: 10, amount: 5160, purchase_time: DateTime.parse('2013-11-08 04:31:41 -0800'), vendor_id: 3, product_id: 4)
    end

    describe "#vendor" do
      it "Returns a Vendor object" do
        @sale.vendor.must_be_instance_of FarMar::Vendor
      end

      it "Returns the vendor associated with a Sale instance" do
        @sale.vendor.name.must_equal "Breitenberg Inc"
      end
    end

    describe "#product" do
      it "Returns a Product object" do
        @sale.product.must_be_instance_of FarMar::Product
      end

      it "Returns the product associated with a Sale instance" do
        @sale.product.name.must_equal "Yummy Fruit"
      end
    end

  end
end
