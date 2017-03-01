require_relative 'spec_helper'

describe FarMar::Vendor do

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

end
