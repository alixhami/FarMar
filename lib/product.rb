module FarMar
  class Product

    attr_reader :id, :name

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
          vendor_id: line[3],
        )
      end
    end

    def self.find(id)
      target = all.select { |product| product.id == id }.first

      raise ArgumentError.new("Invalid product ID.") if target.nil?
      target
    end

  end
end
