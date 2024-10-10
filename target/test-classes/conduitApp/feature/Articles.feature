@Debug
Feature: Articles Creation

Background:Define url
     Given url 'https://conduit-api.bondaracademy.com/api/'
    # Given path 'users/login'
    # And request {"user":{"email":"karatej@gmail.com","password":"karate1234"}}
    # When method Post
    # Then status 200
    
    * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature') {"email":"karatej@gmail.com","password":"karate1234"}
    * def token = tokenResponse.authToken
    
Scenario: New Articles


    # Given header Authorization = 'Token ' + token
    And request {"article":{"title":"test article11221","description":"test article2","body":"test article2","tagList":["test article4"]}}
    And header Content-Type = 'application/json'
    Given path 'articles/'
    When method Post
    And status 201
    And match response.article.title == 'test article11221' 

Scenario: Create, Get and Delete Article

    * def uniqueTitle = 'Jaga ' + Date.now()  // Generate a unique title
    * print 'Unique Title:', uniqueTitle
    * print 'Token:', token
    * def payload = {"article": {"title": "#(uniqueTitle)", "description": "#(uniqueTitle)", "body": "#(uniqueTitle)", "tagList": ["#(uniqueTitle)"]}}
    * print 'Request payload:', payload

    # Given header Authorization = 'Token ' + token
    And request payload 
    And header Content-Type = 'application/json'
    Given path 'articles'
    When method Post
    Then status 201
    * print 'Response:', response
    And match response.article.title == uniqueTitle 
    * def articleId = response.article.slug  // Capture the slug
    * print 'Article ID:', articleId

    Given params {limit:10, offset: 0}  
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles == '#[10]'
    And match response.articles[0].title == uniqueTitle  // Check for the unique title

    # Given header Authorization = 'Token ' + token
    Given path 'articles', articleId  // Correctly formatted path for deletion
    When method Delete
    Then status 200

    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title != uniqueTitle  // Check that the article no longer exists
