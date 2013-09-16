class CreateModel < ActiveRecord::Migration
  def up
  	create_table :messages do |t|
  		t.string :content
  	end
  end

  def down
  	drop_table :messages
  end
end
