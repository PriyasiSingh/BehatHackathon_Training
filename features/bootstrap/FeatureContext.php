<?php

use Drupal\DrupalExtension\Context\RawDrupalContext;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\Behat\Tester\Exception\PendingException;

/**
 * Defines application features from the specific context.
 */
class FeatureContext extends RawDrupalContext {

    public $node_url;
    public $node_id;

  /**
   * Initializes context.
   *
   * Every scenario gets its own context instance.
   * You can also pass arbitrary arguments to the
   * context constructor through behat.yml.
   */
  public function __construct() {
  }

    /**
     * @Then I fill in :arg1 with :
     */
    public function iFillInWith($arg1, PyStringNode $string)
    {
        print($string->getRaw());
    }

    /**
     * @Then I wait :arg1 seconds
     * @Then yo espero :arg1 seconds
     */
    public function iWaitSeconds($arg1)
    {
        sleep($arg1);
    }

    /**
     * @Given /^I wait for page load$/
     */
    public function iWaitForPageLoad()
    {
        $this->getSession()->wait(50000, 'document.readyState == "complete"');
    }

    /**
     * @Then relleno :arg1 con:
     */
    public function rellenoCon($arg1, PyStringNode $string)
    {
        print($string->getRaw());
    }

    /**
     * @When I enter following details
     */
    public function iEnterFollowingDetails(TableNode $table)
    {
        $page = $this->getSession()->getPage();

        foreach ($table as $row)
        {
            var_dump($row);

            $name = $row['Your name'];
            $email =   $row['Your email address'];
            $subject = $row['Subject'];
            $message = $row['Message'];

            $page->find('css','input#edit-name')->setValue($name);
            $page->find('xpath',"//input[@id='edit-mail']")->setValue($email);
            $page->find('css','#edit-subject-0-value')->setValue($subject);
            $page->find('xpath',"//*[@id='edit-message-0-value']")->setValue($message);

        }
    }

    /**
     * @Then I click on :arg1 button
     */
    public function iClickOnButton($arg1)
    {
        $page= $this->getSession()->getPage();
        $page->find(selector:'css',locator: 'a.button--action')->click();
    }

    /**
     * @Then /^I fill in wysiwyg on field "([^"]*)" with "([^"]*)"$/
     */
    public function iFillInWysiwygOnFieldWith($locator, $value)
    {
        $el = $this->getSession()->getPage()->findField($locator);
        $fieldId = $el->getAttribute('id');

        if (empty($fieldId)) {
            throw new Exception('Could not find an id for field with locator: ' . $locator);
        }

        $this->getSession()->executeScript("CKEDITOR.instances[\"$fieldId\"].setData(\"$value\");");
    }

    /**
     * @Then /^I click on "([^"]*)" button with xpath "([^"]*)"$/
     */
    public function iClickOnButtonWithEnAdminStructureTaxonomyManageRecipe_categoryOverview($arg1, $locator)
    {
        $page = $this->getSession()->getPage();
        $page->find('xpath', $locator)->click();
    }

    /**
     * Click on the element with the provided xpath query
     *
     * @When /^I click on the element with xpath "([^"]*)"$/
     */
    public function iClickOnTheElementWithXPath($xpath)
    {
        $session = $this->getSession(); // get the mink session
        $element = $session->getPage()->find(
            'xpath',
            $session->getSelectorsHandler()->selectorToXpath('xpath', $xpath)
        ); // runs the actual query and returns the element

        // errors must not pass silently
        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Could not evaluate XPath: "%s"', $xpath));
        }

        // ok, let's click on it
        $element->click();

    }

    /**
     * Context for autocomplete fields.
     *
     * @param $prefix - value to be selected.
     * @param $field - field name, id, value, label.
     * @throws - Throws Element not found exception.
     *
     * @Given I select :prefix from :field autocomplete field
     */
    public function iSelectFirstAutocomplete($prefix, $field)
    {
        $field = str_replace('\\"', '"', $field);
        $session = $this->getSession();
        $page = $session->getPage();
        $element = $page->findField($field);

        if (!$element) {
            throw new \Behat\Mink\Exception\ElementNotFoundException($session, type:NULL, selector: 'named', locator: $field);
        }

        $page->fillField($field, $prefix);
        $this->iWaitSeconds(2);
        $xpath = $element->getXpath();
        $driver = $session->getDriver();
        $prefix = str_replace('\\"', '"', $prefix);
        $chars = str_split($prefix);
        $last_char = array_pop($chars);

        // autocomplete.js uses key down/up events directly.
        $driver->keyDown($xpath, 8);
        $driver->keyUp($xpath, 8);
        $driver->keyDown($xpath, $last_char);
        $driver->keyUp($xpath, $last_char);

        // Wait for AJAX to finish.
        $this->waitForAjaxAndAnimation();

        // Press the down arrow to select the first option.
        $driver->keyDown($xpath, 40);
        $driver->keyUp($xpath, 40);

        // Press the Enter key to confirm selection, copying the value into the field.
        $driver->keyDown($xpath, 13);
        $driver->keyUp($xpath, 13);

        // Wait for AJAX to finish.
        $this->waitForAjaxAndAnimation();

        // Press the Tab key to remove focus.
        $driver->keyDown($xpath, 9);
        $driver->keyUp($xpath, 9);
    }

    /**
     * Wait until Ajax call and Loading DX8 animation is finished.
     *
     * @var $wait - Max wait time in seconds.
     */
    public function waitForAjaxAndAnimation($wait = 30)
    {
        $script = "(jQuery.active === 0 && jQuery(':animated').length === 0 && jQuery('.is-loading').length === 0)";
        $this->getSession()
            ->wait($wait, $script);
    }

    /**
     * @Then I save the node url
     */
    public function iSaveTheNodeUrl()
    {
        $this->node_url = $this->getSession()->getCurrentUrl();
        echo $this->node_url;
    }

    /**
     *
     * @Then I should be on the node page
     */
    public function assertNodeURL()
    {
        $this->assertSession()->addressEquals($this->node_url);
    }

    /**
     * @Given I navigate to the node url
     */
    public function iAccessNodeUrl()
    {
        $this->visitPath($this->node_url);
    }

    /**
     * @Then I should see :text as first content on the Listing page
     */
    public function assertFirstContentList($text)
    {
        $this->assertSession()->elementTextContains('xpath', "//div[@class='view-content']/div[1]/article[1]", $text);
    }

    /**
     * @Then I should see element :xpath with attribute :attribute has :expectedValue
     */
    public function iShouldSeeElementWithAttributeHas($xpath, $attribute, $expectedValue)
    {
        $this->assertSession()->elementAttributeContains("xpath", $xpath, $attribute, $expectedValue);
    }

    /**
     * @Given /^I should not be able to access "([^"]*)"$/
     */
    public function iShouldNotBeAbleToAccess($url)
    {
        $this->getSession()->visit($this->locatePath($url));
        $this->assertSession()
            ->elementTextContains('css', '.layout-container', 'Access denied');
    }




}
