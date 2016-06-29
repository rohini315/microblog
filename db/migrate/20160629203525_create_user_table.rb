class CreateUserTable < ActiveRecord::Migration
  def change
  	create_table :users do |table|
  		table.string :name
  		table.integer :phone
  		table.string :username
  		table.string :password
  	end
  	create_table :profiles do |table|
  		table.integer :user_id
  		table.string :city
  		table.string :field
  		table.text :bio
  	end

  	create_table :posts do |table|
  		table.integer :user_id
  		table.text :post_text
  		table.text :image
  		table.datetime :date
  		table.boolean :like
  	end
  end
end
