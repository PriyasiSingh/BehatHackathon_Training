Feature: As an Admin user when I create a new recipe
  it is displayed on the Recipe Listing page

  @javascript @api @recipelist
  Scenario: Verify an admin user is able to create
  Recipes content in English language
    Given I am logged in as a user with the "administrator" role
  # Create new terms for Tags and Recipe Category
    When I am viewing a "tags" term with the name "Unique Cake"
    Then I should see the heading "Unique Cake"
    When I am viewing a "recipe_category" term with the name "Nutrition Cake"
    Then I should see the heading "Nutrition Cake"
  # Creating Recipe Content
    When I am on "/en/node/add/recipe"
    And I wait for page load
    Then I should see the heading "Create Recipe"
    When I fill in "Recipe Name" with "Almond Cake"
    And I fill in "Preparation time" with "30"
    Then I fill in "Cooking time" with "60"
    Then I fill in "Number of servings" with "6"
    And I select "Medium" from "Difficulty"
    Then I check the box "Nutrition Cake"
    And I wait for AJAX to finish
    Then I select "Unique Cake" from "Tags" autocomplete field
    And I press the "Add media" button
    And I wait 5 seconds
    And I attach the file "Honey-Almond-Cake.jpg" to "Add file"
    And I wait 5 seconds
    And I fill in "Alternative text" with "Test image"
    And I wait for page load
    And I click on the element with xpath "//button[contains(text(),'Save')]"
    And I wait for page load
    And I click on the element with xpath "//button[contains(text(),'Insert selected')]"
    And I wait for page load
    And I fill in wysiwyg on field "edit-field-summary-0-value" with "Honey almond cake"
    And I fill in "Ingredients (value 1)" with "Refined flour"
    And I press the "Add another item" button
    And I wait for AJAX to finish
    And I fill in "Ingredients (value 2)" with "Oil and Butter"
    And I fill in wysiwyg on field "edit-field-recipe-instruction-0-value" with "Please follow below steps"
    And I select "Draft" from "Save as"
    Then I press the "Save" button
    And I save the node url
    Then I should see the heading "Almond Cake"
    And I should see the link "Unique Cake"
    And I should see the link "Nutrition Cake"
   # Verify Recipe created in Draft state is not displayed first on the Listing Page
    When I click "Recipes" in the "header" region
    And I wait for page load
    Then I should not see "Almond Cake" in the "content" region
    # Verify Recipe created in Published state is displayed first on the Listing Page
    When I navigate to the node url
    And I wait for page load
    Then I break
    When I click "Edit" in the "tabs" region
    And I wait for page load
    Then I should see the heading "Edit Recipe Almond Cake"
    And I select "Published" from "Change to"
    Then I press the "Save" button
    And I wait for page load
    When I am on "/en/recipes"
    Then I should see "Almond Cake" as first content on the Listing page
    When I follow "View Recipe"
    And I wait for page load
    Then I should be on the node page
    # Verify Recipe created in Archived state is not displayed on the Listing Page
    When I click "Edit" in the "tabs" region
    And I wait for page load
    Then I should see the heading "Edit Recipe Almond Cake"
    And I select "Archived" from "Change to"
    Then I press the "Save" button
    And I wait for page load
    When I am on "/en/recipes"
    Then I should not see "Almond Cake" in the "content" region