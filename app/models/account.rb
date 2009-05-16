class Account < ActiveRecord::Base
  belongs_to :client
  has_many :lines

def recalc_total
  newtotal = lines.sum('amount')
  logger.info("wrong total! #{total}, should be #{newtotal}. Updated.") if newtotal != total
  self.total = newtotal  
end

end
