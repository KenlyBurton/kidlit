class CreateBooks < ActiveRecord::Migration
  def up
  	create_table :books do |t|
  		t.string :title
  		t.string :author
  		t.string :genre
      t.integer :age_id
  	end
  end
  def down
  	drop_table :books
  end
end

