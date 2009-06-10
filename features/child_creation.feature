Feature: Create data for a new child in the system
	So that the child can benefit from the system
	
	As an administrator
	I want to create a new child record in the system
	
	Scenario: Create child record
	
		Given child is not already in the system
		And there is a school class available
		When I supply name, class and email address and save
		Then that info should be saved
		
	Scenario: Ensure a child has the correct number of accounts
	
		Given we have defined account types
		When a child is created
		Then it should have an account for each account type


			
		
		