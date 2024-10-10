Feature: Tests for teh HomePage

Background:Define url
    Given url 'https://conduit-api.bondaracademy.com/api/'

@second
Scenario:Get all tags
    
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains ['GitHub','Coding']
    And match response.tags !contains 'Truck' 
    And match response.tags == "#array"
    And match each response.tags == "#string"

Scenario: Get articles
    //Given param limit = 10
    //Given param offset = 0
   
    Given params {limit:10, offset: 0}  
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles == '#[10]'
    And match response.articlesCount == 10