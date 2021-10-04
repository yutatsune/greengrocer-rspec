class Product
  attr_reader :id, :name, :price

  @@count = 30

  def initialize(product_params)
    @id = @@count += 1
    @name = product_params[:name]
    @price = product_params[:price]
  end
end
