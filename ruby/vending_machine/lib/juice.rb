# frozen_string_literal: true

# ジュースを作成するためのクラスです
class Juice
  attr_reader :juice_name, :juice_price, :juice_stock

  # ジュースは名前、値段、在庫の情報を持つ(デフォルトではペプシ、150円、5個の在庫)
  def initialize(juice_name = 'ペプシ', price = 150, stock = 5)
    @juice_name = juice_name
    @juice_price = price
    @juice_stock = stock
  end
end
