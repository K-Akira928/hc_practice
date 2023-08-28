# frozen_string_literal: true

require_relative 'vending_machine'

# 機能を増やした自販機クラスです
class AdvanceVendingMachine < VendingMachine
  # 新たに2種類のジュースインスタンスでジュースを管理できるようにする
  def initialize(juice, second_juice, third_juice)
    super(juice)
    # ジュースのリストに追加した2種類の情報を追加
    @juice_list.store(second_juice.juice_name, { price: second_juice.juice_price, stock: second_juice.juice_stock })
    @juice_list.store(third_juice.juice_name, { price: third_juice.juice_price, stock: third_juice.juice_stock })
  end

  # Suicaの残高と現在の在庫で購入可能なジュースのリストを返す
  def juice_buy_possible_list(suica)
    buy_possible_list = @juice_list.map do |keys, _value|
      keys if suica.deposit >= @juice_list[keys][:price] && @juice_list[keys][:stock].positive?
    end
    buy_possible_list.compact
  end

  # ジュースのストック(在庫)を増やす
  def juice_stock_add(juice_name, num)
    @juice_list[juice_name][:stock] += num
  end
end
