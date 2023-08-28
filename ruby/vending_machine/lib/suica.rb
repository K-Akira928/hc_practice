# frozen_string_literal: true

# Suicaクラスです
class Suica
  attr_reader :deposit

  # デフォルトで500円チャージ
  def initialize
    @deposit = 500
  end

  # Suicaに任意の額をチャージ(100円未満ではエラー)
  def deposit_charge(amount)
    raise 'チャージ額は100円以上で入力してください' if amount < 100

    @deposit += amount
  end

  # Suicaの残高を減らす
  def deposit_sub(price)
    @deposit -= price
  end
end
