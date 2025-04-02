Feature:Récupérer toutes les réservations

  Background:
    * url 'https://restful-booker.herokuapp.com'

  Scenario: Envoyer une requête GET /booking
    Given path '/booking'
    When method GET
    Then status 200
    And match response == '#[]'
    And assert response.length > 0
