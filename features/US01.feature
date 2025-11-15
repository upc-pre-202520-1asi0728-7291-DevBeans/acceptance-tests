# Archivo: us01_registro_productor.feature
# User Story ID: US01
# Título: Registro de Productor Pequeño/Mediano
# Épico: EP01 - Gestión de Usuarios

Feature: Registro de Productor Pequeño/Mediano
  Como productor de café pequeño o mediano
  Quiero registrarme en BeanDetect AI con información básica de mi finca
  Para obtener acceso a la tecnología de clasificación de café

  Background:
    Given el sistema BeanDetect AI está disponible
    And la página de registro de productor está accesible

  Scenario: Registro exitoso de un productor con datos de finca
    Given soy un productor de café pequeño o mediano
    And he completado el formulario de registro con información básica de mi finca (ubicación, hectáreas)
    When envío mi solicitud de registro a BeanDetect AI
    Then debo recibir una confirmación de registro y obtener credenciales de acceso para la tecnología de clasificación

  Scenario Outline: Registro de productores con diferentes tamaños de finca
    Given soy un productor de café pequeño o mediano
    And ingreso mi nombre "<nombre_completo>"
    And ingreso mi email "<email>"
    And ingreso mi contraseña "<password>"
    And selecciono mi ubicación "<ubicacion>"
    And ingreso el tamaño de mi finca "<hectareas>" hectáreas
    And selecciono la variedad de café "<variedad>"
    When envío el formulario de registro
    Then debo recibir un mensaje de confirmación "Registro exitoso"
    And debo recibir un correo de bienvenida a "<email>"
    And mi perfil debe estar creado con el rol "PRODUCTOR"
    
    Examples:
      | nombre_completo    | email                    | password     | ubicacion          | hectareas | variedad |
      | Juan Pérez García  | juan.perez@gmail.com     | Secure123!   | Cusco, Perú        | 2.5       | TYPICA   |
      | María López Torres | maria.lopez@outlook.com  | MyPass456#   | Cajamarca, Perú    | 5.0       | CATURRA  |
      | Carlos Ruiz Díaz   | carlos.ruiz@yahoo.com    | Coffee789$   | Junín, Perú        | 3.8       | BOURBON  |
      | Ana Fernández      | ana.fernandez@gmail.com  | Bean2024@    | Amazonas, Perú     | 1.5       | GEISHA   |

  Scenario Outline: Validación de campos requeridos en el registro
    Given estoy en la página de registro de productor
    And dejo el campo "<campo_vacio>" sin completar
    When intento enviar el formulario de registro
    Then debo ver un mensaje de error "<mensaje_error>"
    And el registro no debe procesarse
    
    Examples:
      | campo_vacio      | mensaje_error                                    |
      | nombre_completo  | El nombre completo es obligatorio                |
      | email            | El correo electrónico es obligatorio             |
      | password         | La contraseña es obligatoria                     |
      | ubicacion        | La ubicación de la finca es obligatoria          |
      | hectareas        | El tamaño de la finca en hectáreas es obligatorio|

  Scenario Outline: Validación de formato de email en el registro
    Given estoy en la página de registro de productor
    And completo todos los campos correctamente
    But ingreso un email con formato inválido "<email_invalido>"
    When intento enviar el formulario de registro
    Then debo ver un mensaje de error "Formato de correo electrónico inválido"
    And el registro no debe procesarse
    
    Examples:
      | email_invalido       |
      | productor.com        |
      | @gmail.com           |
      | productor@          |
      | productor gmail.com  |
      | productor@.com       |

  Scenario: Intento de registro con email ya existente
    Given existe un productor registrado con email "juan.perez@gmail.com"
    And estoy en la página de registro de productor
    When intento registrarme con el mismo email "juan.perez@gmail.com"
    Then debo ver un mensaje de error "Este correo electrónico ya está registrado"
    And debo tener la opción de recuperar mi contraseña
    And el registro no debe procesarse