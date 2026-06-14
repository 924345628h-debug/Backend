Feature: actualizacion de usuario por ID en ServeRest

  Background:
    * url baseUrl


  Scenario Outline: Actualizar usuario válido
    Given path '/usuarios'
    And request { "nome": "<nombre>", "email": "<email>", "password": "<password>", "administrador": "<administrador>" }
    When method post
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'
    * def userId = response._id

    Given path '/usuarios/' + userId
    And request { "nome": "<nombreActualizado>", "email": "<email>", "password": "<password>", "administrador": "<administrador>" }
    When method put
    Then status 200
    And match response.message == "Registro alterado com sucesso"
    Examples:
      | nombre    | nombreActualizado | email               | password | administrador |
      | katherine | Stefany           | Katherine2@test.com | 123456   | true          |


  Scenario Outline: Actualizar usuario con correo existente
    Given path '/usuarios'
    And request { "nome": "<nome>", "email": "<email>", "password": "<password>", "administrador": "<administrador>" }
    When method post
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'
    * def userId = response._id

    Given path '/usuarios/' + userId
    And request { "nome": "<nome>", "email": "<emailUpdate>", "password": "<password>", "administrador": "<administrador>" }
    When method put
    Then status 400
    And match response.message == "Este email já está sendo usado"
Examples:
  | emailUpdate         | nome      | email           | password | administrador |
  | Katherine2@test.com | katherine | Update@test.com | 1234     | true          |