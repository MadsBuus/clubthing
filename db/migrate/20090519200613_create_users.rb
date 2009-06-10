class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :crypted_password

      t.timestamps
    end
    
    User.create(:name => 'admin', :password => '1234')
  end

  def self.down
    drop_table :users
  end
end
