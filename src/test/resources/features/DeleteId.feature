Feature: Delete SERVEREST

  Background:
    * url baseUrl


  Scenario Outline: Eliminar usuario válido
    Given path '/usuarios'
    And request { "nome": "<nome>", "email": "<email>", "password": "<password>", "administrador": "<administrador>" }
    When method post
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'
    * def userId = response._id

    Given path '/usuarios/' + userId
    When method delete
    Then status 200
    And match response.message == "Registro excluído com sucesso"
    Examples:
      | nome   | email           | password | administrador |
      | Delete | Delete@test.com | 1234     | true          |


  Scenario: Eliminar usuario con carrito
    Given path '/usuarios/0uxuPY0cbmQhpEz1'
    When method delete
    Then status 400
    And match response.message == "Não é permitido excluir usuário com carrinho cadastrado"
