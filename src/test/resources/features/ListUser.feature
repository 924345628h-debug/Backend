Feature: Listado de Usuarios en ServeRest

  Background:
    * url baseUrl


  Scenario: Obtener lista de usuarios
    Given path '/usuarios'
    When method get
    Then status 200