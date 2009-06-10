include ChildHelper

Given /^child is not already in the system$/ do
  @child = nil    
end

Given /^there is a school class available$/ do
  @klass = Klass.create(:startyear => '2005', :name => 'x')
end

When /^I supply name, class and email address and save$/ do
  @child = stub_child
end

Then /^that info should be saved$/ do
  @child.id.should > 0 && Child.find_by_name('Mads').should_not == nil 
end

# ------------------------------------------------------------------------------

Given /^we have defined account types$/ do
  assert AccountType.count == 3
end

When /^a child is created$/ do  
  @child = stub_child
end

Then /^it should have an account for each account type$/ do
  @child.accounts.should have_exactly(3).items
end

#-------------------------------------------------------------------------------