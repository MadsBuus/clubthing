class AddDateStampsOnLines < ActiveRecord::Migration
  def self.up
    add_column :lines, :date, :date
        
    #restamp existing...
    Line.all.each do |line|
      line.date = line.created_at.to_date
      line.save
    end
  end

  def self.down
    remove_column :lines, :date
  end
end
