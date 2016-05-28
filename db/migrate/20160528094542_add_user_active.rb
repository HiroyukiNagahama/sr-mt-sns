class AddUserActive < ActiveRecord::Migration
  def change
    add_column(:users,:active_flag,:boolean,default: true,comments: "有効フラグ")
  end
end
