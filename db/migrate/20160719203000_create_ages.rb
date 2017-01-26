class CreateAges < ActiveRecord::Migration
  def up
  	create_table :ages do |t|
  		t.string :age_group
  	end
  end
  def down
  	drop_table :ages
  end
end

