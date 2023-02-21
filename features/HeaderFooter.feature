
Feature: As an Anonymous User
  I should be able to verify the footer components

  @javascript @en @header
  Scenario Outline: Verify the header components are displayed
  for anonymous user on English site
    Given I am on "<Page>"
  # Verify top header
    Then I should see the link "English" in the "header" region
    Then I should see the link "Spanish" in the "header" region
    Then I should see the link "Log in" in the "header" region
    And I should see the "Search" button
    When I click "Spanish" in the "header" region
    Then I should be on "/es"
    Then I click "English" in the "header" region
    Then I should be on "/en"
    When I press "Search" in the "header" region
    Then I should be on "/en/search/node?keys="
    When I click "Log in" in the "header" region
    Then I should be on "/en/user/login"
   #Verify header region
    Then I should see the link "Home" in the "header" region
    When I click "Home" in the "header" region
    Then I should be on "/en"
    And I should see "Articles" in the "header" region
    When I click "Articles" in the "header" region
    Then I should be on "/en/articles"
    And I should see the link "Recipes" in the "header" region
    When I click "Recipes" in the "header" region
    Then I should be on "/en/recipes"
   # Verify logo class
    And I should see element "//*[@id='block-umami-branding']/a" with attribute "class" has "site-logo"
   # Verify Logo URL
    And I should see element "//*[@id='block-umami-branding']/a/img" with attribute "src" has "/core/profiles/demo_umami/themes/umami/logo.svg"
    # Verify Logo Alt text
    And I should see element "//*[@id='block-umami-branding']/a/img" with attribute "alt" has "Home"
    Examples:
      | Page           |
      | /en           |
      | /en/contact/   |
      | /en/search/node  |

  @javascript @en @footer
  Scenario Outline: Verify the Footer and Copyright text
  on the Umami site in English
    Given I am on "<Page>"
  #Verify Footer region
    And I should see the text "Umami Food Magazine" in the "footer" region
    And I should see the text "Skills and know-how. Magazine exclusive articles, recipes and plenty of reasons to get your copy today." in the footer region
    And I should see the link "Find out more" in the "footer" region
    And I should see "Tell us what you think" in the "footer" region
    And I should see the link "Contact" in the "footer" region
  # Verify the links are working in the footer
    When I click "Find out more" in the "footer" region
    Then I should be on "/en/about-umami"
    When I click "Contact" in the "footer" region
    Then I should be on "/en/contact"
  #Verify the footer image
#    Then I break
    And I should see element "//img[@alt='3 issue bundle of the Umami food magazine']" with attribute "src" has "/sites/default/files/styles/medium_8_7/public/umami-bundle.png?itok=eRPgdRHu"
    #Verify Copyright text
    Then I should see "Umami Magazine & Umami Publications is a fictional magazine and publisher for illustrative purposes only" in the "copyright" region
    And I should see "© 2022 Terms & Conditions" in the "copyright" region
    Examples:
      | Page           |
      | /en           |
      | /en/contact   |
      | /en/search/node  |

