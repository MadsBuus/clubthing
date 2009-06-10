class CreateChildren < ActiveRecord::Migration
  def self.up
    create_table :children do |t|
      t.string :name
      t.integer :klass_id
      t.string :email
      t.string :address
      t.timestamps
    end
  end

  def self.down
    drop_table :children
  end
end
