class Account < ActiveRecord::Base
  belongs_to :account_type
  belongs_to :child
  has_many :lines, :order => "date DESC", :dependent => :destroy

  def recalc_total
    newtotal = lines.sum('amount')
    logger.info("wrong total! #{total}, should be #{newtotal}. Updated.") if newtotal != total
    self.total = newtotal 
    self.save 
  end
end
