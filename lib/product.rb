module FarMar
  class Product

    attr_reader :id, :name, :vendor_id

    def initialize(product_info)
      @id = product_info[:id].to_i
      @name = product_info[:name]
      @vendor_id = product_info[:vendor_id].to_i
    end

    def self.all
      CSV.open('support/products.csv').collect do |line|
        Product.new(
          id: line[0],
          name: line[1],
          vendor_id: line[2],
        )
      end
    end

    def self.find(id)
      target = all.select { |product| product.id == id }.first

      raise ArgumentError.new("Invalid product ID.") if target.nil?
      target
    end

    def self.by_vendor(vndr_id)
      all.select { |product| product.vendor_id == vndr_id }
    end

    def vendor
      Vendor.find(@vendor_id)
    end

    def sales
      Sale.all.select { |sale| sale.product_id == @id }
    end

    def number_of_sales
      sales.count
    end

  end
end
