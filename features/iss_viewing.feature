Feature: ISS Viewing
  In order to see viewing opportunities
  As a guest
  I want to show the ISS Viewing page

	Scenario: Show ISS Viewing page
  	  Given I have cities named Tulsa, Sapulpa in Oklahoma
	  When I go to the iss viewing page
	  Then I should see "Oklahoma"
	  And I should see "Tulsa"
	  And I should see "Sapulpa"