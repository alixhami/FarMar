module FarMar
  class Market

    attr_accessor :id, :name

    def initialize(market_info)
      @id = market_info[:id].to_i
      @name = market_info[:name]
      @street_address = market_info[:street_address]
      @city = market_info[:city]
      @county = market_info[:county]
      @state = market_info[:state]
      @zip = market_info[:zip]
    end

    def self.all
      CSV.open('support/markets.csv').collect do |line|
        Market.new(
          id: line[0],
          name: line[1],
          street_address: line[2],
          city: line[3],
          county: line[4],
          state: line[5],
          zip: line[6]
        )
      end
    end

    def self.find(id)
      target = all.select { |market| market.id == id }.first

      raise ArgumentError.new("Invalid market ID.") if target.nil?
      target
    end

    def vendors
      Vendor.all.select { |vendor| vendor.market_id == @id }
    end

  end
end
