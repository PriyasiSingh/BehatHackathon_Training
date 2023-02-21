
Feature:Unable to access admin menus as an Authenticated user

  @en @javascript @api @authen
  Scenario: Verify Authenticated user  does not have permissions to create
  content and admin menu
    Given I am logged in as a user with the "authenticated" role
    # Anonymous user is unable to create content
    Then I should not be able to access "/en/admin/content"
    Then I should not be able to access "/en/node/add/article"
    And I should not be able to access "/en/node/add/recipe"
    And I should not be able to access "/en/node/add/page"
    #Anonymous user does not have access to people and reports
    Then I should not be able to access "/en/admin/people"
    And I should not be able to access "/en/admin/reports"
    # Anonymous user is unable to access Structure and child menus
    And I should not be able to access "/en/admin/structure"
    And I should not be able to access "/en/admin/structure/block"
    And I should not be able to access "/en/admin/structure/contact"
    And I should not be able to access "/en/admin/structure/types"
    And I should not be able to access "/en/admin/structure/display-modes"
    And I should not be able to access "/en/admin/structure/media"
    And I should not be able to access "/en/admin/structure/taxonomy"
    And I should not be able to access "/en/admin/structure/views"
    #Anonymous user is unable access to Appearance
    And I should not be able to access "/en/admin/appearance"
    # Anonymous user is unable to access Modules
    Then I should not be able to access "/en/admin/modules"

