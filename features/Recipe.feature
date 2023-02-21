#language: en

Feature: Create Recipe content as Author user
  As a content author I should be able to Create New Draft transition
  and Move content from Draft, Published states to Draft state
  and View the latest version

  Background:
    Given I am on homepage

  @javascript @api @CreateRecipeContent
  Scenario: As a content author I am able to create, edit and delete own content of type Recipe
    Given I am logged in as a user with the Author role
    And I follow "Content"
      #Creating new content of type Recipe
    Then I click on "Add content" button
    When I click "Recipe"
    And I wait 3 seconds
    Then I should see the heading "Create Recipe"
    When I fill in "Recipe Name" with "Author test recipe"
    And I fill in "Preparation time" with "15min"
    And I fill in "Cooking time" with "10min"
    And I fill in "Number of servings" with "2"
    And I select "Easy" from "Difficulty"
    And I check the box "Desserts"
    And I check the box "Accompaniments"
    Then I select "Test food" from "Tags" autocomplete field
    And I wait for AJAX to finish
    And I wait 3 seconds
    And I press the "Add media" button
    And I wait 5 seconds
    And I check the box "Carrot.png"
    And I wait 5 seconds
    And I click on the element with xpath "//button[contains(text(),'Insert selected')]"
    And I wait for page load
    And I fill in wysiwyg on field "edit-field-summary-0-value" with "Test Summary"
    And I fill in wysiwyg on field "edit-field-recipe-instruction-0-value" with "Test Recipe"
    And I wait 3 seconds
    And I select "Draft" from "Save as"
    Then I press the "Save" button
    And I wait 5 seconds
    Then I should see the heading "Author test recipe"





