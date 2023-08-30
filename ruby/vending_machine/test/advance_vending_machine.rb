# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/advance_vending_machine'
require_relative '../lib/juice'
require_relative '../lib/suica'

# 拡張された自動販売機のテストクラスです
class AdvanceVendingMachineTest < Minitest::Test
  def setup
    pepsi = ['ペプシ', 150]
    monster = ['モンスター', 230]
    ilohas = ['いろはす', 120]
    @suica = Suica.new
    @adv_vending_machine = AdvanceVendingMachine.new(pepsi, monster, ilohas)
  end

  # 拡張された自動販売機は3種類のジュースを購入できる
  def test_adv_vending_machine_offer_three_types_of_juice_for_buy
    @adv_vending_machine.juice_buy(@suica, 'ペプシ')
    @adv_vending_machine.juice_buy(@suica, 'モンスター')
    @adv_vending_machine.juice_buy(@suica, 'いろはす')

    # 購入後全てのジュースの在庫が-1
    assert_equal 4, @adv_vending_machine.juice_stock('ペプシ')
    assert_equal 4, @adv_vending_machine.juice_stock('モンスター')
    assert_equal 4, @adv_vending_machine.juice_stock('いろはす')

    # 売上金額が、150+230+120=500 となる
    assert_equal 500, @adv_vending_machine.sales_amount

    # 売上金額が500ということはSuicaの残高は0
    assert_equal 0, @suica.deposit
  end

  # 拡張された自動販売機は購入可能なジュースのリストを返す
  def test_adv_vending_machine_buy_possible_list
    # Suicaの残高が500円かつ在庫十分なので全て購入可能
    assert_equal %w[ペプシ モンスター いろはす], @adv_vending_machine.juice_buy_possible_list(@suica)

    # Suicaの残高を120円に調整(期待されるのはいろはすのみ)
    @adv_vending_machine.juice_buy(@suica, 'ペプシ')
    @adv_vending_machine.juice_buy(@suica, 'モンスター')
    assert_equal %w[いろはす], @adv_vending_machine.juice_buy_possible_list(@suica)

    # ジュースの在庫がなくても表示されない
    @suica.deposit_charge(1000)
    4.times { @adv_vending_machine.juice_buy(@suica, 'ペプシ') }
    assert_equal %w[モンスター いろはす], @adv_vending_machine.juice_buy_possible_list(@suica)
  end

  # 拡張された自動販売機は在庫を補充できる
  def test_vending_machines_can_replenish_stock
    # ペプシの在庫を+3, モンスターを+2, いろはすを+1
    @adv_vending_machine.juice_stock_add('ペプシ', 3)
    @adv_vending_machine.juice_stock_add('モンスター', 2)
    @adv_vending_machine.juice_stock_add('いろはす', 1)

    # 在庫を+した結果
    assert_equal 8, @adv_vending_machine.juice_stock('ペプシ')
    assert_equal 7, @adv_vending_machine.juice_stock('モンスター')
    assert_equal 6, @adv_vending_machine.juice_stock('いろはす')
  end
end
