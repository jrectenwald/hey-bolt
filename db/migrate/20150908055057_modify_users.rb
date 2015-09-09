class ModifyUsers < ActiveRecord::Migration
  def up
    change_column :users, :profile_picture, :string
  end

  def down
    change_column :users, :profile_picture, :binary
  end
end
