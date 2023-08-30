# frozen_string_literal: true

# 自動販売機クラス
class VendingMachine
  attr_reader :sales_amount

  # ジュースの情報を渡してインスタンスを生成する(デフォルトではペプシ、150円)
  def initialize(juice = ['ペプシ', 150])
    # ジュースのリストをハッシュで作成
    first_juices = []
    5.times { first_juices.push Juice.new(juice[0], juice[1]) }
    @juice_list = { juice[0] => first_juices }
    # 自動販売機の売上金額
    @sales_amount = 0
  end

  # ジュースの購入処理
  def juice_buy(suica, juice_name)
    raise 'チャージ額またはジュースの在庫がありません' unless juice_buy?(suica, juice_name)

    # 自販機内のジュースの在庫を減らし、ジュースの値段分Suicaから引く、ジュースの値段分自販機の売上金額に追加
    @sales_amount += @juice_list[juice_name].first.juice_price
    suica.deposit_sub(@juice_list[juice_name].first.juice_price)
    @juice_list[juice_name].delete_at(0)
  end

  # ジュースのストックを確認
  def juice_stock(juice_name)
    @juice_list[juice_name].size
  end

  # Suicaの残高とジュースのストックで購入可能か判定
  def juice_buy?(suica, juice_name)
    juice_stock(juice_name).positive? && suica.deposit >= @juice_list[juice_name].first.juice_price
  end
end
