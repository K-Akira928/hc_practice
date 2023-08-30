# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/suica'

# Suicaをテストするクラスです
class SuicaTest < Minitest::Test
  # セットアップとしてSuicaのインスタンスを作成
  def setup
    @suica = Suica.new
  end

  # デフォルトで500円がチャージされているか確認
  def test_default_deposit
    assert_equal 500, @suica.deposit
  end

  # Suicaは100円以上の場合チャージできる
  def test_more_than_100yen_can_be_charged_to_suica
    assert @suica.deposit_charge(100)
    # 100円チャージ後(600円)かを確認
    assert_equal 600, @suica.deposit
  end

  # Suicaは100円未満の場合エラーを出力する
  def test_less_than_100yen_cannot_be_charged_to_suica
    e = assert_raises RuntimeError do
      @suica.deposit_charge(99)
    end
    assert_equal 'チャージ額は100円以上で入力してください', e.message
  end
end
