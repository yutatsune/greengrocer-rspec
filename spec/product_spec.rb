RSpec.describe Product do
  describe '.initialize' do
    context 'インスタンスが生成されたとき' do
      let(:product_params) { { name: 'トマト', price: 100 } }
      let(:product) { Product.new(product_params) }
      let!(:base_id) { Product.class_variable_get('@@count') }
      it '@@countが1増加すること' do
        expect { Product.new(product_params) }
          .to change { Product.class_variable_get('@@count') }.by(1)
      end

      it '商品の@idが、インスタンス生成前の@@countに+1した値と等しいこと' do
        expect(product.id).to eq base_id + 1
      end

      it '商品の@nameが，product_paramsの名前と等しいこと' do
        expect(product.name).to eq 'トマト'
      end

      it '商品の@priceが，product_paramsの金額と等しいこと' do
        expect(product.price).to eq 100
      end
    end
  end
end
