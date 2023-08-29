# frozen_string_literal: true

# ジュースを作成するためのクラスです
class Juice
  attr_reader :juice_name, :juice_price

  # ジュースは名前、値段、の情報を持つ
  def initialize(juice_name, price)
    @juice_name = juice_name
    @juice_price = price
  end
end
