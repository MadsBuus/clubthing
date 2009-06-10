class CreateAccountTypes < ActiveRecord::Migration
  def self.up
    create_table :account_types do |t|
      t.string :title

      t.timestamps
    end
    
    AccountType.create(:id => 1, :title => 'Mad')
    AccountType.create(:id => 2, :title => 'Bar')
    AccountType.create(:id => 3, :title => 'Aktiviteter')
  end

  def self.down
    drop_table :account_types
  end
end
