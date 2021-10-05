class Greengrocer
  attr_reader :products

  def initialize(product_params)
    @products = []
    register_product(product_params)
  end

  def register_product(product_params)
    product_params.each do |param|
      @products << Product.new(param)
    end
  end

  def disp_products
    puts 'いらっしゃいませ！商品を選んで下さい。'
    @products.each do |product|
      puts "#{product.id}.#{product.name}" "(¥#{product.price})"
    end
  end
end
