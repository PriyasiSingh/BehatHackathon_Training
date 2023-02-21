#language: en

Feature: An authenticated & anonymous user should be able to search the content
  in both english and spanish language

  @en @search
  Scenario: Verify search results are displayed as per the entered keywords
    for anonymous user
    Given I am on homepage
    When I fill in "edit-keys" with "nut"
    And press "Search"
    Then I should see "nut" in the ".item-list" element

  @en @search
  Scenario: Verify error message is displayed when "blank" keywords is used
    Given I am on homepage
    When I fill in "edit-keys" with " "
    And press "Search"
    And I wait for page load
    Then I should see the error message "Please enter some keywords"

  @en @search
  Scenario: Verify proper message is displayed when non-matching keywords is used
    Given I am on homepage
    When I fill in "edit-keys" with "corona"
    And press "Search"
    And I wait for page load
    Then I should see "Your search yielded no results" in the ".item-list" element

  @api @en @search
  Scenario: Verify search results are displayed as per the entered keywords
  for authenticated user
    Given I am logged in as a user with the Authenticated role
    And I am on homepage
    When I fill in "edit-keys" with "nut"
    And press "Search"
    Then I should see "nut" in the ".item-list" element

  @es @search
  Scenario: Verify search results are displayed as per the entered keywords in Spanish language
  for anonymous user
    Given I am on homepage
    And I follow "Spanish" in the header region
    When I fill in "edit-keys" with "nueces"
    And press "Buscar"
    Then I should see "nueces" in the ".item-list" element

  @api @en @adv-search
  Scenario: Verify admin user is able to perform advance search
  and results are displayed as per the entered keywords
    Given I am logged in as a user with the "Administrator" role
    And I am on homepage
    And I am on "/en/search"
    Then I should see "Advanced Search"
    When I click on "Advanced Search" button with xpath "//*[@id='edit-advanced']/summary"
    And I wait for page load
    When I fill in "Containing any of the words" with "brownies"
    And I check the box "English"
    And I click on "Advanced search" button with xpath "//*[@id='edit-submit--2']"
    And I wait 5 seconds
    Then I should see "brownies" in the ".item-list" element
    When I fill in "Containing the phrase" with "Baking mishaps"
    And I check the box "Article"
    And I check the box "English"
    And I click on "Advanced search" button with xpath "//*[@id='edit-submit--2']"
    And I wait 5 seconds
    Then I should not see "brownies" in the ".item-list" element
    When I fill in "Containing none of the words" with "brownies"
    And I check the box "English"
    And I click on "Advanced search" button with xpath "//*[@id='edit-submit--2']"
    And I wait 5 seconds
    Then I should not see "brownies" in the ".item-list" element
