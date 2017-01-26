class CreateReviews < ActiveRecord::Migration
  def up
  	create_table :reviews do |t|
  		t.string :content
  		t.integer :book_id
  	end
  end
  def down
  	drop_table :reviews
  end
end

