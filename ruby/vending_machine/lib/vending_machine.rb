# frozen_string_literal: true

# 自動販売機クラス
class VendingMachine
  attr_reader :sales_amount

  # ジュースインスタンスを渡して自動販売機を作成します
  def initialize(juice)
    # ジュースのリストをハッシュで作成
    @juice_list = {}
    @juice_list.store(juice.juice_name, { price: juice.juice_price, stock: juice.juice_stock })

    # 自動販売機の売上金額
    @sales_amount = 0
  end

  # ジュースの購入処理
  def juice_buy(suica, juice_name)
    raise 'チャージ額またはジュースの在庫がありません' unless juice_buy?(suica, juice_name)

    # 自販機内のジュースの在庫を減らし、ジュースの値段分Suicaから引く、ジュースの値段分自販機の売上金額に追加
    @juice_list[juice_name][:stock] -= 1
    # suica.deposit_juice_price_sub(@juice_list[juice_name][:price])
    @sales_amount += @juice_list[juice_name][:price]
    suica.deposit_sub(@juice_list[juice_name][:price])
  end

  # ジュースのストックを確認
  def juice_stock(juice_name)
    @juice_list[juice_name][:stock]
  end

  # Suicaの残高とジュースのストックで購入可能か判定
  def juice_buy?(suica, juice_name)
    juice_stock(juice_name).positive? && suica.deposit >= @juice_list[juice_name][:price]
  end
end
