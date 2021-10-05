RSpec.describe User do
  let(:user) { User.new }
  describe '.choose_product' do
    let(:products) do
      [
        Product.new({ name: 'トマト', price: 100 }),
        Product.new({ name: 'きゅうり', price: 200 })
      ]
    end
    let(:correct_product_id_input) { "#{products.first.id}\n" }
    context '存在するid（productsの最初の要素のid）を入力したとき' do
      before do
        allow(ARGF).to receive(:gets).and_return correct_product_id_input
        user.choose_product(products)
      end
      it '@chosen_productのidが，productsの最初の要素のidと等しいこと' do
        expect(user.chosen_product.id).to eq correct_product_id_input.to_i
      end

      it '@chosen_productの名前が，productsの最初の要素の名前と等しいこと' do
        expect(user.chosen_product.name).to eq 'トマト'
      end

      it '@chosen_productの金額が，productsの最初の要素の金額と等しいこと' do
        expect(user.chosen_product.price).to eq 100
      end
    end
    let(:prompt_re_enter_msg) { /#{products.first.id}から#{products.last.id}の番号から選んでください。/ }
    shared_examples '再入力を促すこと' do
      it do
        allow(ARGF).to receive(:gets).and_return wrong_product_id_input, correct_product_id_input
        expect { user.choose_product(products) }.to output(prompt_re_enter_msg).to_stdout
      end
    end
    context '商品一覧の最初のidより１小さい数値を入力したとき' do
      let(:wrong_product_id_input) { "#{products.first.id - 1}\n" }
      it_behaves_like '再入力を促すこと'
    end

    context '商品一覧の最後のidより１大きい数値を入力したとき' do
      let(:wrong_product_id_input) { "#{products.last.id + 1}\n" }
      it_behaves_like '再入力を促すこと'
    end

    context '数値以外の文字列を入力したとき' do
      let(:wrong_product_id_input) { "hoge\n" }
      it_behaves_like '再入力を促すこと'
    end
  end

  describe '.decide_quantity' do
    shared_examples '@quantity_of_productが，入力値を整数化した値と等しいこと' do
      it do
        allow(ARGF).to receive(:gets).and_return correct_quantity_input
        user.decide_quantity
        expect(user.quantity_of_product).to eq correct_quantity_input.to_i
      end
    end

    context '1を入力したとき' do
      let(:correct_quantity_input) { "1\n" }
      it_behaves_like '@quantity_of_productが，入力値を整数化した値と等しいこと'
    end

    context '2〜100の数値のいずれかを入力したとき' do
      let(:correct_quantity_input) { "#{rand(2..100)}\n" }
      it_behaves_like '@quantity_of_productが，入力値を整数化した値と等しいこと'
    end

    let(:prompt_re_enter_msg) { /１個以上選んでください。/ }

    shared_examples '再入力を促すこと' do
      it do
        allow(ARGF).to receive(:gets).and_return wrong_quantity_input, correct_quantity_input
        expect { user.decide_quantity }.to output(prompt_re_enter_msg).to_stdout
      end
    end

    context '0を入力したとき' do
      let(:wrong_quantity_input) { "0\n" }
      let(:correct_quantity_input) { "1\n" }
      it_behaves_like '再入力を促すこと'
    end

    context '負の数値を入力したとき' do
      let(:wrong_quantity_input) { "0\n" }
      let(:correct_quantity_input) { "1\n" }
      it_behaves_like '再入力を促すこと'
    end

    context '数値以外の文字列を入力したとき' do
      let(:wrong_quantity_input) { "0\n" }
      let(:correct_quantity_input) { "1\n" }
      it_behaves_like '再入力を促すこと'
    end
  end
end
