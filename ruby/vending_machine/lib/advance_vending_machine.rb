# frozen_string_literal: true

require_relative '../lib/vending_machine'

# 機能を増やした自販機クラスです
class AdvanceVendingMachine < VendingMachine
  # 新たに2種類のジュースインスタンスでジュースを管理できるようにする
  def initialize(juice, second_juice, third_juice)
    super(juice)
    # ジュースのリストに追加した2種類の情報を追加
    second_juices = []
    third_juices = []
    5.times { second_juices.push Juice.new(second_juice[0], second_juice[1]) }
    5.times { third_juices.push Juice.new(third_juice[0], third_juice[1]) }
    @juice_list.store(second_juice[0], second_juices)
    @juice_list.store(third_juice[0], third_juices)

    # ジュースの設計図を保管
    @juice_info_list = [juice, second_juice, third_juice]
  end

  # Suicaの残高と現在の在庫で購入可能なジュースのリストを返す
  def juice_buy_possible_list(suica)
    buy_possible_list = @juice_list.map do |key, _value|
      key if @juice_list[key].size.positive? && suica.deposit >= @juice_list[key].first.juice_price
    end
    buy_possible_list.compact
  end

  # ジュースのストック(在庫)を増やす
  def juice_stock_add(juice_name, num)
    index = @juice_info_list.map.with_index do |juice, i|
      i if juice_name == juice[0]
    end
    index = index.compact[0]
    num.times { @juice_list[juice_name].push Juice.new(@juice_info_list[index][0], @juice_info_list[index][1]) }
  end
end
