# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/zenigame'

# ピカチュウをテストするクラスです
class ZenigameTest < Minitest::Test
  def setup
    @zenigame = Zenigame.new('ゼニガメ', 'みず', '', 100)
  end

  # 名前を取得できるかテスト
  def test_get_name
    assert_equal 'ゼニガメ', @zenigame.name
  end

  # ゼニガメは独自のこうげきができるかテスト
  def test_zenigame_can_attack
    assert_equal 'ゼニガメのみずでっぽう！', @zenigame.attack
  end

  # 名前を変更できるかテスト
  def test_name_change
    @zenigame.change_name('カメール')
    assert_equal 'カメール', @zenigame.name
  end

  # 不適切な名前(うんこ)で変更しようとした場合エラー
  def test_misnomer_error
    e = assert_raises RuntimeError do
      @zenigame.change_name('うんこ')
    end
    assert_equal '不適切な名前です', e.message
  end
end
