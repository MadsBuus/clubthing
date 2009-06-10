module ChildHelper
  def stub_child
      klass = Klass.find_or_create_by_startyear('2005', :name => 'x')
      Child.create(:name => 'Mads', :klass => klass, :email => 'mads@buus.net')    
  end
end