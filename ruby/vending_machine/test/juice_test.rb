# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/juice'

# ジュース作成をテストするクラスです
class JuiceTest < Minitest::Test
  def setup
    @juice = Juice.new
  end

  # ジュースは名前、値段、在庫の情報を持っている
  # デフォルトではペプシの情報が格納されている
  def test_juice_has_name_price_stock_info
    assert_equal 'ペプシ', @juice.juice_name
    assert_equal 150, @juice.juice_price
    assert_equal 5, @juice.juice_stock
  end

  # ジュースの名前、値段、在庫を指定して作成したインスタンスが機能しているか
  def test_another_juice_instance
    another_juice = Juice.new('アクエリアス', 140, 3)
    assert_equal 'アクエリアス', another_juice.juice_name
    assert_equal 140, another_juice.juice_price
    assert_equal 3, another_juice.juice_stock
  end
end
