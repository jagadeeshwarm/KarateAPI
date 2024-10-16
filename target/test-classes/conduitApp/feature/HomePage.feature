Feature: Tests for teh HomePage

Background:Define url
    Given url apiUrl

@second
Scenario:Get all tags
    
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains ['Test','Coding']
    And match response.tags !contains 'Truck' 
    And match response.tags !contains ['Fish', ''dog']
    And match response.tags == "#array"
    And match each response.tags == "#string"

Scenario: Get articles
    //Given param limit = 10
    //Given param offset = 0

    * def timevalidator = read('classpath:helpers/TimeValidator.js')
   
    Given params {limit:10, offset: 0}  
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles == '#[10]'
    And match response.articlesCount == 10
    And match response.articlesCount !== 100
    And match response = {"articles":"#array", "articlesCount": 500} //fuzzy matching
    And match response.articles[0].createdAt contains '2021'
    And match response.articles[*].favoritesCount contains 1
    And match response..bio contains null
    And match each response..following == '#boolean'
    And match each response.articles[*].favoritesCount == '#number'
    And match each response ==
    """
        {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": [
                "#array"
            ],
            "createdAt": "#? timevalidator(_)",
            "updatedAt": "#? timevalidator(_)",
            "favorited": '#array',
            "favoritesCount": '#boolean',
            "author": {
                "username": "Artem Bondar",
                "bio": null,
                "image": "#string",
                "following": 'boolean'
            }

    """
    
    
    
