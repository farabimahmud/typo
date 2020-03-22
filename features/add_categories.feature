Feature: Add Categories
  As a blog administrator
  In order to sort topics of the blog 
  I want to be able to create categories

  Background:
    Given the blog is set up
    And I am logged into the admin panel

  Scenario: Successfully create categories
    Given I am on the categories page
    When I fill in "category_name" with "Foobar"
    And I fill in "category_keywords" with "Lorem Ipsum"
    And I fill in "category_permalink" with "Lorem Ipsum"
    And I press "Save"
    Then I should be on the edit categories page
    When I go to the categories page 
    Then I should see "Foobar"
    When I follow "Foobar"
    Then I should see "Lorem Ipsum"
