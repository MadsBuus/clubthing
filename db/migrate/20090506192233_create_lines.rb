class CreateLines < ActiveRecord::Migration
  def self.up
    create_table :lines do |t|
      t.integer :account_id
      t.integer :amount
      t.text :comment
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :lines
  end
end
