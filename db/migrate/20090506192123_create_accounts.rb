class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.integer :account_type_id
      t.integer :child_id
      t.string :atype
      t.integer :total

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
