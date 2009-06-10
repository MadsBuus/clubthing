Feature: Remove data for a new child in the system
	So that the child is no longer registered in the database
	
	As an administrator
	I want to remove a new child record (and all associated information) from the database

	Scenario: Ensure a when a child is deleted, so is the corresponding accounts

		Given a child is in the database and we have defined account types
		When a child is deleted
		Then all the child accounts should also be deleted
