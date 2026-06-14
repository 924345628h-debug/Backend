Feature: busqueda de usuario por ID en ServeRest

  Background:
    * url baseUrl


  Scenario: Buscar usuario por ID
    Given path '/usuarios'
    When method get
    Then status 200
    * def userId = response.usuarios[1]._id

    Given path '/usuarios/' + userId
    When method get
    Then status 200
    And match response contains { nome: '#string', email: '#string' }


  Scenario: Buscar usuario inexistente
    Given path '/usuarios/0uxuPY0cbmQh123123'
    When method get
    Then status 400

