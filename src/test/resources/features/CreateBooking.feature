Feature:Créer une nouvelle réservation

  Background:
    * url 'https://restful-booker.herokuapp.com'
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'

  Scenario: POST /booking avec données de test
    Given path '/booking'
    And request
    """
    {
      "firstname": "Pierre",
      "lastname": "Martin",
      "totalprice": 150,
      "depositpaid": true,
      "bookingdates": {
        "checkin": "2024-05-01",
        "checkout": "2024-05-05"
      },
      "additionalneeds": "Petit déjeuner"
    }
    """
    When method POST
    Then status 200
    And match response.bookingid != null
