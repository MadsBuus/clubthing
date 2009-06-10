module ChildrenHelper
  def revisor(number)
    pad = number.to_s.rjust(5,' ')
    style = (number <= 0) ? 'neg' : 'pos'
    "<span class='#{style}'>#{pad}</span>"
  end
end
