class Account < ActiveRecord::Base
  belongs_to :client
  has_many :lines
end
