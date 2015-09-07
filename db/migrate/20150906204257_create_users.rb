class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :bolt_connection
      t.string :email
      t.date :birthday
      t.binary :profile_picture
    end
  end
  def down
    drop_table :users
  end
end
