Feature: Registro de Usuarios en ServeRest

  Background:
    * url baseUrl


  Scenario Outline: Registrar usuario válido
    Given path '/usuarios'
    And request { "nome": "<nome>", "email": "<email>", "password": "<password>", "administrador": "<administrador>" }
    When method post
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'
    * def userId = response._id
    Examples:
      | nome          | email            | password | administrador |
      | Usuario Test1 | prueba3@test.com | 1234     | true          |


  Scenario Outline: Registrar usuario duplicado
    Given path '/usuarios'
    And request { "nome": "<nome>", "email": "<email>", "password": "<password>", "administrador": "<administrador>" }
    When method post
    Then status 400
    And match response.message == 'Este email já está sendo usado'
    Examples:
      | nome          | email            | password | administrador |
      | Usuario Test1 | prueba3@test.com | 1234     | true          |
