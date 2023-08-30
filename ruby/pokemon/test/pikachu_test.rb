# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/pikachu'

# ピカチュウをテストするクラスです
class PikachuTest < Minitest::Test
  def setup
    @pikachu = Picachu.new('ピカチュウ', 'でんき', '', 100)
  end

  # 名前を取得できるかテスト
  def test_get_name
    assert_equal 'ピカチュウ', @pikachu.name
  end

  # ピカチュウは独自のこうげきができるかテスト
  def test_pikachu_can_attack
    assert_equal 'ピカチュウの10万ボルト！', @pikachu.attack
  end

  # 名前を変更できるかテスト
  def test_name_change
    @pikachu.change_name('ライチュウ')
    assert_equal 'ライチュウ', @pikachu.name
  end

  # 不適切な名前(うんこ)で変更しようとした場合エラー
  def test_misnomer_error
    e = assert_raises RuntimeError do
      @pikachu.change_name('うんこ')
    end
    assert_equal '不適切な名前です', e.message
  end
end
