module FarMar
  class Vendor

    attr_reader :id, :name, :market_id

    def initialize(vendor_info)
      @id = vendor_info[:id].to_i
      @name = vendor_info[:name]
      @employee_count = vendor_info[:employee_count].to_i
      @market_id = vendor_info[:market_id].to_i
    end

    def self.all
      CSV.open('support/vendors.csv').collect do |line|
        Vendor.new(
          id: line[0],
          name: line[1],
          employee_count: line[2],
          market_id: line[3]
        )
      end
    end

    def self.find(id)
      target = all.select { |vendor| vendor.id == id }.first

      raise ArgumentError.new("Invalid vendor ID.") if target.nil?
      target
    end

    def self.by_market(mkt_id)
      all.select { |vendor| vendor.market_id == mkt_id }
    end

    def market
      Market.find(@market_id)
    end

    def products
      Product.all.select { |product| product.vendor_id == @id }
    end

    def sales
      Sale.all.select { |sale| sale.vendor_id == @id }
    end

    def revenue
      sales.map { |sale| sale.amount }.reduce(:+)
    end

  end
end
