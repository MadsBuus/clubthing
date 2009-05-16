class Client < ActiveRecord::Base
  has_many :accounts
  validates_presence_of :name
  validates_uniqueness_of :name
  
  def account(atype)
    accounts.find_by_atype(atype)
  end
end
