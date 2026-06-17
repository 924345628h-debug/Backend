Feature: Registro de Usuarios en ServeRest

Background:
    * url baseUrl

@test
Scenario Outline: Registrar usuario válido

    * def timestamp = java.lang.System.currentTimeMillis()
    * def emailBase = '<email>'
    * def partes = emailBase.split('@')
    * def emailDinamico = partes[0] + timestamp + '@' + partes[1]

    Given path '/usuarios'
    And request
    """
    {
      "nome": "<nome>",
      "email": "#(emailDinamico)",
      "password": "<password>",
      "administrador": "<administrador>"
    }
    """
    When method post

    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'
    And match response._id == '#string'

    Examples:
      | nome          | email           | password | administrador |
      | Usuario Test1 | prueb1@test.com | 1234     | true          |

@test
Scenario Outline: Registrar usuario duplicado

    * def timestamp = java.lang.System.currentTimeMillis()
    * def emailBase = '<email>'
    * def partes = emailBase.split('@')
    * def emailDinamico = partes[0] + timestamp + '@' + partes[1]

    Given path '/usuarios'
    And request
    """
    {
      "nome": "<nome>",
      "email": "#(emailDinamico)",
      "password": "<password>",
      "administrador": "<administrador>"
    }
    """
    When method post
    Then status 201

    Given path '/usuarios'
    And request
    """
    {
      "nome": "<nome>",
      "email": "#(emailDinamico)",
      "password": "<password>",
      "administrador": "<administrador>"
    }
    """
    When method post

    Then status 400
    And match response.message == 'Este email já está sendo usado'

    Examples:
      | nome          | email           | password | administrador |
      | Usuario Test1 | prueb1@test.com | 1234     | true          |
