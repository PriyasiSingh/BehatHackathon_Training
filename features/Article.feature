Feature: As an admin user
  I am able to create article CT
  I am able to edit,delete article CT

  @javascript @api @article
  Scenario: Verify as an admin user I am able to create article CT
    Given I am logged in as a user with the "administrator" role
    And I follow "Content"
    Then I click on "Add content" button with xpath "//*[@id='block-claro-local-actions']/ul/li/a"
    And I follow "Article"
    Then I should see the heading "Create Article"
    And I wait 5 seconds
    And I fill in "Title" with "Baking Hacks"
    And I select "Hacks" from "Tags" autocomplete field
    And I fill in wysiwyg on field "edit-body-0-value" with "Hacks for baking"
    And I press the "Add media" button
    And I wait for page load
    And I wait 10 seconds
    And I attach the file "tree.png" to "Add file"
    And I wait 20 seconds
    And I fill in "Alternative text" with "Test image"
    And I wait for page load
    And I click on the element with xpath "//button[contains(text(),'Save')]"
    And I wait for page load
    And I click on the element with xpath "//button[contains(text(),'Insert selected')]"
    And I wait for page load
    And I select "Published" from "Save as"
    And I press the "Save" button
    And I wait for page load
    Then I should see the heading "Baking Hacks"
    And I should see the link "Hacks"
    And I should see the text "Hacks for baking"
    # verify the article content is editable
    When I click "Edit" in the "tabs" region
    And I wait for page load
    And I fill in "Title" with "Update Baking Hacks"
    Then I select "new update" from "Tags" autocomplete field
    And I wait 30 seconds
    And I fill in wysiwyg on field "edit-body-0-value" with "Updating Baking hacks for party"
    And I press "edit-field-media-image-selection-0-remove-button"
    And I wait for page load
    And I press the "Add media" button
    And I wait for page load
    And I attach the file "Carrot.png" to "Add file"
    And I wait 5 seconds
    And I fill in "Alternative text" with "Test image"
    And I wait for page load
    And I click on the element with xpath "//button[contains(text(),'Save')]"
    And I wait for page load
    And I click on the element with xpath "//button[contains(text(),'Insert selected')]"
    And I wait for page load
    And I press the "Save" button
    And I wait for page load
    Then I should see the heading "Update Baking Hacks"
    And I should see the link "new update"
    And I should see the text "Updating Baking hacks for party"
  # Verify Article Content is Reverted successfully
    When I click "Revisions" in the "tabs" region
    And I wait 10 seconds
    And I click "Revert" in the "content" region
    And I wait for page load
    Then I should see "Are you sure you want to revert to the revision from"
    When I press "Revert"
    And I wait for page load
    Then I should see the success message "Article Baking Hacks has been reverted to the revision"
#  # Verify Editor has access to delete the Revision
#    When I click on the element with xpath "//tr[@class='odd']//button[@type='button']"
##    Then I break
##    And I select "Delete" from "List additional actions"
#    And I wait 3 seconds
#    And I follow "Delete" in the content region
#    And I wait for page load
#    Then I should see "Are you sure you want to delete the content item"
#    When I press "Delete"
#    And I should see "The Article Baking Hacks has been deleted"
#    Then I break

    # Delete the Article content
    When I click "Delete"
    And I wait for page load
    Then I should see "Are you sure you want to delete the content item"
    When I press "Delete"
    And I wait for page load
    Then I am on homepage