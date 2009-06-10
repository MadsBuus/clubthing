class Klass < ActiveRecord::Base
  has_many :children, :order => :name
  validates_presence_of :startyear, :name, :message => 'skal udfyldes'
  validates_numericality_of :startyear, :message => "ikke et årstal"
  validates_format_of :startyear, :with => /^2[0-9]{3}$/, :message => "ugyldigt årstal"
  validates_length_of :name, :within => 1..1, :message => "kun ét bogstav"
  validate :startyear_at_most_today
  
  def startyear_at_most_today
    errors.add_to_base("kan ikke oprette klasser fra fremtiden") unless year >= 0 
  end
  
  def year 
    today = Date.today
    year = today.year - startyear
    if today.month < 7
      year -= 1 
    end
    year    
  end

  def display
    "#{year}.#{name}"
  end
end
