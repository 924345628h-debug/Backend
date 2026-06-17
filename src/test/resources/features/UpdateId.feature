Feature: actualizacion de usuario por ID en ServeRest

Background:
    * url baseUrl

    * def generateEmail =
    """
    function(emailBase){
      var partes = emailBase.split('@');
      return partes[0] + java.lang.System.currentTimeMillis() + '@' + partes[1];
    }
    """

@test
Scenario Outline: Actualizar usuario válido

    * def emailDinamico = generateEmail('<email>')

    Given path '/usuarios'
    And request
    """
    {
      "nome": "<nombre>",
      "email": "#(emailDinamico)",
      "password": "<password>",
      "administrador": "<administrador>"
    }
    """
    When method post

    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'

    * def userId = response._id

    Given path '/usuarios/' + userId
    And request
    """
    {
      "nome": "<nombreActualizado>",
      "email": "#(emailDinamico)",
      "password": "<password>",
      "administrador": "<administrador>"
    }
    """
    When method put

    Then status 200
    And match response.message == 'Registro alterado com sucesso'

Examples:
    | nombre    | nombreActualizado | email              | password | administrador |
    | katherine | Stefany           | katherine@test.com | 123456   | true          |


@test
Scenario Outline: Actualizar usuario con correo existente

    * def emailExistente = generateEmail('<emailUpdate>')
    * def emailUsuario = generateEmail('<email>')

    Given path '/usuarios'
    And request
    """
    {
      "nome": "UsuarioExistente",
      "email": "#(emailExistente)",
      "password": "<password>",
      "administrador": "<administrador>"
    }
    """
    When method post
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'

    Given path '/usuarios'
    And request
    """
    {
      "nome": "<nome>",
      "email": "#(emailUsuario)",
      "password": "<password>",
      "administrador": "<administrador>"
    }
    """
    When method post
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'

    * def userId = response._id

    Given path '/usuarios/' + userId
    And request
    """
    {
      "nome": "<nome>",
      "email": "#(emailExistente)",
      "password": "<password>",
      "administrador": "<administrador>"
    }
    """
    When method put

    Then status 400
    And match response.message == 'Este email já está sendo usado'

Examples:
    | emailUpdate         | nome      | email           | password | administrador |
    | Katherine5@test.com | katherine | Update@test.com | 1234     | true          |
