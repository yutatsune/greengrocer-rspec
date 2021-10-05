class User
  attr_reader :chosen_product, :quantity_of_product

  def choose_product(products)
    while true
      print '商品の番号を選択 >'
      select_product_id = gets.to_i
      @chosen_product = products.find { |product| product.id == select_product_id }
      break unless @chosen_product.nil?

      puts "#{products.first.id}から#{products.last.id}の番号から選んでください。"
    end
  end

  def decide_quantity
    while true
      print '個数を入力 >'
      @quantity_of_product = gets.to_i
      break if @quantity_of_product >= 1

      puts '１個以上選んでください。'
    end
  end
end
