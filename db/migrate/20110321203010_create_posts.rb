class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :type
      t.string :title
      t.text :content
      t.timestamps
      t.integer :user_id
    end
  end

  def self.down
  end
end
