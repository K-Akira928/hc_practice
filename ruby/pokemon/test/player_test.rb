# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/player'

# プレイヤークラスをテストするクラスです
class PlayerTest < Minitest::Test
  def setup
    @satoshi = Player.new('サトシ')
  end

  # プレイヤーの名前を取得できるかテスト
  def test_get_name
    assert_equal 'サトシ', @satoshi.name
  end

  # プレイヤーの名前を変更できるかテスト
  def test_change_name
    @satoshi.change_name('レッド')
    assert_equal 'レッド', @satoshi.name
  end

  # 不適切な名前(うんこ)で変更しようとした場合エラー
  def test_misnomer_error
    e = assert_raises RuntimeError do
      @satoshi.change_name('うんこ')
    end
    assert_equal '不適切な名前です', e.message
  end
end
