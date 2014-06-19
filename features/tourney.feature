Feature: Drawing tournament bracket
  In order to show the complete tournament schedule
  I want to draw a bracket on its own page

  Scenario: Press the tournament button
    Given I am logged in
    And   I visit "/"
    And I click "tournament-button"
    Then I should see "Tournament Schedule"
