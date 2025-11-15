# Archivo: us02_registro_cooperativa.feature
# User Story ID: US02
# Título: Registro de Cooperativa Cafetalera
# Épico: EP01 - Gestión de Usuarios

Feature: Registro de Cooperativa Cafetalera
  Como administrador de una cooperativa cafetalera
  Quiero registrar mi organización en BeanDetect AI
  Para gestionar la clasificación de múltiples productores asociados

  Background:
    Given el sistema BeanDetect AI está disponible
    And la página de registro de cooperativa está accesible

  Scenario: Registro exitoso de la organización cooperativa
    Given soy el administrador de una cooperativa cafetalera
    And tengo la información legal y operativa de la organización
    When registro mi organización en BeanDetect AI
    Then el sistema debe crear un perfil de cooperativa que me permita gestionar la clasificación de múltiples productores asociados

  Scenario Outline: Registro de cooperativas con diferentes características
    Given soy el administrador de una cooperativa cafetalera
    And ingreso el nombre de la cooperativa "<nombre_cooperativa>"
    And ingreso el email institucional "<email>"
    And ingreso la contraseña "<password>"
    And ingreso el número de RUC "<ruc>"
    And ingreso la dirección legal "<direccion>"
    And selecciono la región "<region>"
    And ingreso el número de productores asociados "<num_productores>"
    And ingreso el nombre del representante legal "<representante>"
    When envío el formulario de registro de cooperativa
    Then debo recibir un mensaje de confirmación "Cooperativa registrada exitosamente"
    And debo recibir un correo de bienvenida a "<email>"
    And mi perfil debe estar creado con el rol "COOPERATIVA"
    And debo tener acceso al panel de gestión de productores asociados
    
    Examples:
      | nombre_cooperativa           | email                        | password    | ruc          | direccion                    | region          | num_productores | representante         |
      | Cooperativa Café del Norte   | admin@cafenorte.org.pe       | CoopPass1!  | 20123456789  | Av. Principal 123, Cajamarca | Cajamarca       | 45              | Roberto Sánchez       |
      | Café Orgánico Cusco          | contacto@cafeorganico.pe     | Organic2@   | 20987654321  | Jr. Los Incas 456, Cusco     | Cusco           | 68              | Patricia Morales      |
      | Asociación Cafetalera Junín  | info@cafejunin.pe            | Junin345#   | 20456789123  | Calle Real 789, Junín        | Junín           | 32              | Miguel Torres         |
      | Cooperativa Valle Verde      | gerencia@valleverde.org.pe   | Verde789$   | 20147852369  | Av. Comercio 321, Amazonas   | Amazonas        | 55              | Carmen Vega           |

  Scenario Outline: Validación de campos obligatorios para cooperativas
    Given estoy en la página de registro de cooperativa
    And dejo el campo "<campo_vacio>" sin completar
    When intento enviar el formulario de registro
    Then debo ver un mensaje de error "<mensaje_error>"
    And el registro no debe procesarse
    
    Examples:
      | campo_vacio        | mensaje_error                                         |
      | nombre_cooperativa | El nombre de la cooperativa es obligatorio            |
      | email              | El correo electrónico institucional es obligatorio    |
      | password           | La contraseña es obligatoria                          |
      | ruc                | El número de RUC es obligatorio                       |
      | direccion          | La dirección legal es obligatoria                     |
      | representante      | El nombre del representante legal es obligatorio      |

  Scenario Outline: Validación de formato de RUC
    Given estoy en la página de registro de cooperativa
    And completo todos los campos correctamente
    But ingreso un RUC con formato inválido "<ruc_invalido>"
    When intento enviar el formulario de registro
    Then debo ver un mensaje de error "Formato de RUC inválido. Debe contener 11 dígitos"
    And el registro no debe procesarse
    
    Examples:
      | ruc_invalido  |
      | 123456789     |
      | 2012345678A   |
      | 201234        |
      | ABCDEFGHIJK   |
      | 20-12345678-9 |

  Scenario: Intento de registro con RUC ya existente
    Given existe una cooperativa registrada con RUC "20123456789"
    And estoy en la página de registro de cooperativa
    When intento registrarme con el mismo RUC "20123456789"
    Then debo ver un mensaje de error "Este RUC ya está registrado en el sistema"
    And debo tener información de contacto para soporte
    And el registro no debe procesarse

  Scenario: Verificación de capacidades del perfil de cooperativa
    Given he registrado exitosamente mi cooperativa "Cooperativa Café del Norte"
    When accedo a mi panel de administración
    Then debo poder ver la opción "Gestionar Productores Asociados"
    And debo poder ver la opción "Clasificación por Lotes"
    And debo poder ver la opción "Reportes Consolidados"
    And debo poder ver la opción "Gestión de Certificaciones"