class ChangeUserPhoneDatatype < ActiveRecord::Migration
  def change
  	change_column :users, :phone, :text
  end
end
