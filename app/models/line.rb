#ActiveRecord fix for multiple group by's

# note: be careful to ensure that your group_by do not use the delimitter (chr(7) or chr(9))
# usage:
#   self.multi_count(:id, :distinct => true, :group => [:symptom_id, :treatment_id])        
#   [[["138", "1018"], 187], [["138", "427"], 373], [["6", "1018"], 197], [["6", "427"], 393]]
class ActiveRecord::Base  
  def self.multi_count(field, opts = {})
    opts[:group] = opts[:group].map!{|group| "coalesce(#{group}::text, chr(7))"}.join(' || chr(9) || ') unless opts[:group].nil?
    self.count(field, opts).map! { |key,value| [key.split("\t").map!{|k| k == "\x07" ? nil : k}, value] }
  end

  def self.multi_sum(field, opts = {})
    opts[:group] = opts[:group].map!{|group| "coalesce(#{group}::text, chr(7))"}.join(' || chr(9) || ') unless opts[:group].nil?
    self.sum(field, opts).map! { |key,value| [key.split("\t").map!{|k| k == "\x07" ? nil : k}, value] }
  end

end

class Line < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  validates_presence_of :amount, :on => :create, :message => "Tal skal angives (Skriv + foran for at sætte penge ind)"
  validates_numericality_of :amount, :on => :create,
    :less_than_or_equal_to => 1000, :greater_than_or_equals_to => -1000, :message => "ugyldig talværdi"

  def deposit
    account.transaction do
      save
      account.total += amount
      account.save
    end
  end
  
  def before_save
    self.date = Time.today
  end
end
