class Indexes < ActiveRecord::Migration
  def self.up 
    add_index :children, :klass_id
    add_index :children, :name
    add_index :accounts, :child_id
    add_index :accounts, :account_type_id
    add_index :lines, :account_id
    add_index :lines, :date         
  end

  def self.down
    remove_index :lines, :date
    remove_index :lines, :account_id
    remove_index :accounts, :account_type_id
    remove_index :accounts, :child_id
    remove_index :children, :name
    remove_index :children, :klass_id
  end
end
