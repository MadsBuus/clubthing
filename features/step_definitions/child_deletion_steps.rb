include ChildHelper

Given /^a child is in the database and we have defined account types$/ do
  @child = stub_child
  @accounts = @child.accounts
  assert_equal(@accounts.count, AccountType.count)
end

When /^a child is deleted$/ do
  @child.destroy
end

Then /^all the child accounts should also be deleted$/ do
  @accounts.each do |dead|
    Account.should_not be_exist(dead) 
    #this test is meaningless unless we have account lines
    lines = Line.find_by_account_id(dead.id)
    lines.should be_nil
  end    
end
