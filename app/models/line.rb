class Line < ActiveRecord::Base
  belongs_to :account
  validates_presence_of :amount, :on => :create, :message => "Tal skal angives (Skriv + foran for at sætte penge ind)"
  validates_numericality_of :amount, :on => :create,  
    :less_than_or_equal_to => 1000, :greater_than_or_equals_to => -1000, :message => "ugyldig talværdi"                
end
