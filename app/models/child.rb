class Child < ActiveRecord::Base
  has_many :accounts, :dependent => :destroy  
  has_many :lines, :through => :accounts
  belongs_to :klass
  validates_presence_of :name, :klass, :message => 'skal udfyldes'
  validates_uniqueness_of :name, :message => 'er allerede i brug'
  validates_format_of :email, :allow_blank => true, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => 'adresse ugyldig'

  def account(account_type_id)
    accounts.find(:first, :conditions => {:account_type_id => account_type_id})
  end

  def after_create
    AccountType.all.each do |account_type|
      Account.create!(:account_type => account_type, :child => self, :total => 0)
    end
  end
end
