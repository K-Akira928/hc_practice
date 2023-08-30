# frozen_string_literal: true

# 名前変更に関するモジュールです
module NameService
  attr_reader :name

  def change_name(new_name)
    # 不適切な名前はエラー
    raise '不適切な名前です' if new_name == 'うんこ'

    @name = new_name
  end
end
