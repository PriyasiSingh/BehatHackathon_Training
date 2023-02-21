Feature: ContactForm

  Background:
    Given I am on the homepage

  Scenario: Contact form data (mSg with Pystring)
    When I follow "English" in the header region
    And I follow "Contact" in the footer region
    Then I should see "Website feedback"
    And I fill in "Your name" with "John"
    And I fill in "Your email address" with "priyasi.singh@axelerant.com"
    And I fill in "Subject" with "First test"
    And I fill in "Message" with:
      """
      Dear,

      Its been more than a week, I am working on it.

      Thanks,
      Priyasi Singh
      """
    And I press "Send message"
    And I wait 5 seconds
    Then I should see "The website encountered an unexpected error"

    @ForValidInput
    Scenario Outline: Contact form data for valid input
      When I follow "English" in the header region
      And I follow "Contact" in the footer region
      Then I should see "Website feedback"
      And I fill in "Your name" with "<name>"
      And I fill in "Your email address" with "<email>"
      And I fill in "Subject" with "<sub>"
      And I fill in "Message" with "<msg>"
      Examples:
        |name|email|sub|msg|
        |John|john@gmail.com|First test|How are you|
        |Steven|Steven@yahoo.com|Second test|How about you|
      And I press "Send message"
      And I wait 5 seconds
      Then I should see "The website encountered an unexpected error"

  @ForInputInformofTable
  Scenario: Contact form data in tabular format
    When I follow "English" in the header region
    And I follow "Contact" in the footer region
    Then I should see "Website feedback"
    When I enter following details
    | Your name | Your email address | Subject | Message |
    | Priyasi   | priyasisingh@gmail.com | First Sub | How are you|

    And I wait 10 seconds
    And I press "Send message"
    And I wait 5 seconds
    Then I should see "The website encountered an unexpected error"

  @ForInValidInput
  Scenario Outline: Contact form data for Invalid input
    When I follow "English" in the header region
    And I follow "Contact" in the footer region
    Then I should see "Website feedback"
    And I fill in "Your name" with "<name>"
    And I fill in "Your email address" with "<email>"
    And I fill in "Subject" with "<sub>"
    And I fill in "Message" with "<msg>"
    Examples:
      |name|email|sub|msg|
      |John||First test|How are you|
      |Steven|Steven@yahoo.com|Second test||
    And I press "Send message"
    And I wait 5 seconds
    Then I should see "Website feedback"
