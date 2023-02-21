#language: en

  Feature: Create  content as Author user
    As a content author I should be able to Create New Draft transition
    and Move content in Draft, Published states to Draft state
    and View the latest version

    Background:
      Given I am on homepage

    @SuccessfulLogin
    Scenario: Login as Content Author is successfull
      When I follow "Log in" in the header region
      And I fill in "Username" with "ConAuth"
      And I fill in "Password" with "ConAuth"
      And I press "Log in"
      Then I should see "My account" in the header region

    @api @CreateContent
    Scenario: As a content author I am able to create, edit and delete own content of type Basic Page
      Given I am logged in as a user with the Author role
      And I follow "Content"
      #Creating new content of type Basic
      When I am on "/node/add/page"
      And I wait for page load
      Then I should see the heading "Create Basic page"
      When I fill in "Title" with "Author test Basic Page"
      And I select "English" from "Language"
      And I fill in wysiwyg on field "edit-body-0-value" with "Basic Page is getting created"
      And I wait for page load
      And I select "Draft" from "Save as"
      Then I press the "Save" button
      And I wait for page load
      Then I should see the heading "Author test Basic Page"

      #Editing the content of type Recipe
      When I click "Edit" in the "tabs" region
      And I wait for page load
      And I fill in "Title" with "Author Edit test Basic Page"
      And I fill in wysiwyg on field "edit-body-0-value" with "Basic page edited and updated"
      And I press the "Save" button
      And I wait for page load
      Then I should see the heading "Author Edit test Basic Page"
      And I should see the link "Author Edit test Basic Page"

      # Verify Author can delete revisions but not revert it to previous revisions
      When I click "Revisions" in the "tabs" region
      And I wait for page load
      Then I should see the heading "Revisions for Author Edit test Basic Page"
      And I should not see the button "Revert"
      And I should see the link "Delete"
      When I click "Delete" in the "content" region
      And I wait 5 seconds
      Then I should see "Are you sure you want to delete the revision"
      When I press the "Delete" button
      And I wait for page load
      And I should see "of Basic page Author test Basic Page has been deleted."







