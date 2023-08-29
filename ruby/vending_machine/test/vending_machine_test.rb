# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/vending_machine'
require_relative '../lib/juice'
require_relative '../lib/suica'

# 自動販売機をテストするクラスです
class VendingMachineTest < Minitest::Test
  def setup
    @suica = Suica.new
    # ジュースのインスタンス生成に必要な情報を記述
    pepsi = ['ペプシ', 150]
    @vending_machine = VendingMachine.new(pepsi)
  end

  # 自動販売機はジュースを購入できる
  def test_vending_machines_can_buy_canned_juice
    # 購入処理
    @vending_machine.juice_buy(@suica, 'ペプシ')
    # ペプシ1缶を購入後の値
    assert_equal 4, @vending_machine.juice_stock('ペプシ')
    assert_equal 150, @vending_machine.sales_amount
    assert_equal 350, @suica.deposit
  end

  # ジュースの在庫を取得できる
  def test_vending_machine_can_get_stock
    assert_equal 5, @vending_machine.juice_stock('ペプシ')
  end

  # 購入できるか判断できる
  def test_determine_if_you_can_buy
    assert @vending_machine.juice_buy?(@suica, 'ペプシ')

    # Suicaの残高が足りないためfalse
    3.times { @vending_machine.juice_buy(@suica, 'ペプシ') }
    assert_equal false, @vending_machine.juice_buy?(@suica, 'ペプシ')

    # 残高はあるが在庫が足りないためfalse
    @suica.deposit_charge(1000)
    2.times { @vending_machine.juice_buy(@suica, 'ペプシ') }
    assert_equal false, @vending_machine.juice_buy?(@suica, 'ペプシ')
  end

  # 自動販売機は売上金額を取得できる
  def test_vending_machines_can_capture_sales_amounts
    # 1個も売れていないので0円
    assert_equal 0, @vending_machine.sales_amount

    # 合計2個売れたので300円
    2.times { @vending_machine.juice_buy(@suica, 'ペプシ') }
    assert_equal 300, @vending_machine.sales_amount

    # 合計3個売れたので450円
    @vending_machine.juice_buy(@suica, 'ペプシ')
    assert_equal 450, @vending_machine.sales_amount
  end
end
