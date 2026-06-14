# Proyecto Karate - ServeRest CRUD de Usuarios

Este proyecto implementa pruebas automatizadas de API utilizando **Karate DSL**.  
El objetivo es validar las operaciones CRUD de usuarios en el servicio [ServeRest](https://serverest.dev).

---

##  Estructura del Proyecto

- **src/test/resources/features**  
  - `DeletedId.feature` → Pruebas de eliminación de usuarios  
  - `ListUser.feature` → Pruebas de listado de usuarios  
  - `RegisterUser.feature` → Pruebas de registro de usuarios  
  - `SearchId.feature` → Pruebas de búsqueda de usuarios por ID  
  - `UpdateId.feature` → Pruebas de actualización de usuarios  

- **karate-config.js**  
  Configuración global del proyecto:
  ```javascript
  function fn() {
    var config = {};
    config.baseUrl = 'https://serverest.dev';
    return config;
  }
