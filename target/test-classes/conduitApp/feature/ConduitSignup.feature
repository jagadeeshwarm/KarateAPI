
Feature: Sign up

    Background: url
        * def datgenerator = Java.type('helpers.DataGenerator')
    Given url apiUrl

    @test
    Scenario Outline: New user Sign up

        * def randomEmail = datgenerator.getRandomEmail()
        * def randomusers = datgenerator.getRandomUsername()

    Given path 'users'
    And request
    """
        {
            "user":{
                "email":"<email>",
                "password":"<password>",
                "username":"<username>"
                }
        }
    """
    When method Post
   
    # And match response ==

    # """
    #     {
    #         "user": {
    #             "id": "#number",
    #             "email": "<email>",
    #             "username": "<username>",
    #             "bio": null,
    #             "image": "#string",
    #             "token": "#string"
    #         }
    #     }
    # """
        
        And match response == <errorresponse>

Examples:

|   email                       | password          |   username            |   errorresponse                                       |
|   #(randomEmail)              | jagan@102419      |   jagatest32123       |   {"errors":{"username": ["has already been taken"]}} |
|   jagatesttt1@gmail.com       | jagan@102419      |   #(randomusers)      |   {"errors":{"email": ["has already been taken"]}}    |
|                               | jagan@102419      |   #(randomusers)      |   {"errors":{"email": ["can't be blank"]}}            |
|   #(randomEmail)              | jagan@102419      |                       |   {"errors":{"username": ["can't be blank"]}}         |
|                               | jagan@102419      |                       |   {"errors":{"email": ["can't be blank"]}}            |
|                               |                   |                       |   {"errors":{"email": ["can't be blank"]}}            |
|   #(randomEmail)              | jagan@102419      |   ja                  |   {"errors":{"username": ["has already been taken"]}} |

    
