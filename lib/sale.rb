module FarMar
  class Sale

    attr_reader :id, :amount, :purchase_time, :vendor_id, :product_id

    def initialize(sale_info)
      @id = sale_info[:id].to_i
      @amount = sale_info[:amount].to_f/100.round(2)
      @purchase_time = sale_info[:purchase_time]
      @vendor_id = sale_info[:vendor_id].to_i
      @product_id = sale_info[:product_id].to_i
    end

    def self.all
      CSV.open('support/sales.csv').collect do |line|
        Sale.new(
          id: line[0],
          amount: line[1],
          purchase_time: DateTime.parse(line[2]),
          vendor_id: line[3],
          product_id: line[4]
        )
      end
    end

    def self.find(id)
      target = all.select { |sale| sale.id == id }.first

      raise ArgumentError.new("Invalid sale ID.") if target.nil?
      target
    end

    def self.between(beginning_time, end_time)
      all.select { |sale| sale.purchase_time.between?(beginning_time, end_time) }
    end

    def vendor
      Vendor.find(@vendor_id)
    end

    def product
      Product.find(@product_id)
    end

  end
end
