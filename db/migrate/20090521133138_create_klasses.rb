class CreateKlasses < ActiveRecord::Migration
  def self.up
    create_table :klasses do |t|
      t.integer :startyear
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :klasses
  end
end
