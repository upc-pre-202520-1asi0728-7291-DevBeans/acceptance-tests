# Archivo: us03_autenticacion_usuarios.feature
# User Story ID: US03
# Título: Autenticación de Usuarios
# Épico: EP01 - Gestión de Usuarios

Feature: Inicio de Sesión Seguro para Usuarios Registrados
  Como usuario registrado (productor o cooperativa)
  Quiero iniciar sesión de forma segura
  Para acceder a las funcionalidades del sistema según mi perfil

  Background:
    Given el sistema BeanDetect AI está disponible
    And la página de inicio de sesión está accesible

  Scenario: Acceso seguro al sistema con credenciales correctas
    Given soy un usuario registrado (productor o cooperativa)
    And proporciono mi nombre de usuario y contraseña correctos
    When intento iniciar sesión en BeanDetect AI
    Then el sistema debe permitir mi acceso de forma segura y dirigir a la interfaz según mi perfil de usuario

  Scenario Outline: Inicio de sesión exitoso con diferentes tipos de usuarios
    Given existe un usuario registrado con email "<email>" y rol "<rol>"
    And estoy en la página de inicio de sesión
    When ingreso el email "<email>"
    And ingreso la contraseña "<password>"
    And hago clic en el botón "Iniciar Sesión"
    Then debo ser autenticado exitosamente
    And debo ser redirigido a "<pagina_destino>"
    And debo ver el mensaje de bienvenida "Bienvenido, <nombre_usuario>"
    
    Examples:
      | email                      | password    | rol         | nombre_usuario  | pagina_destino              |
      | juan.perez@gmail.com       | Secure123!  | PRODUCTOR   | Juan Pérez      | /dashboard/productor        |
      | admin@cafenorte.org.pe     | CoopPass1!  | COOPERATIVA | Café del Norte  | /dashboard/cooperativa      |
      | maria.lopez@outlook.com    | MyPass456#  | PRODUCTOR   | María López     | /dashboard/productor        |
      | contacto@cafeorganico.pe   | Organic2@   | COOPERATIVA | Café Orgánico   | /dashboard/cooperativa      |

  Scenario Outline: Validación de credenciales incorrectas
    Given existe un usuario registrado con email "<email>"
    And estoy en la página de inicio de sesión
    When ingreso el email "<email>"
    And ingreso una contraseña incorrecta "<password_incorrecta>"
    And hago clic en el botón "Iniciar Sesión"
    Then debo ver un mensaje de error "Credenciales inválidas. Por favor, verifica tu email y contraseña"
    And no debo ser autenticado
    And debo permanecer en la página de inicio de sesión
    
    Examples:
      | email                      | password_incorrecta |
      | juan.perez@gmail.com       | WrongPass123        |
      | admin@cafenorte.org.pe     | IncorrectPwd        |
      | maria.lopez@outlook.com    | BadPassword         |

  Scenario Outline: Intento de inicio de sesión con usuario inexistente
    Given no existe ningún usuario registrado con email "<email_inexistente>"
    And estoy en la página de inicio de sesión
    When ingreso el email "<email_inexistente>"
    And ingreso cualquier contraseña "<password>"
    And hago clic en el botón "Iniciar Sesión"
    Then debo ver un mensaje de error "Usuario no encontrado. Por favor, verifica tu email o regístrate"
    And no debo ser autenticado
    
    Examples:
      | email_inexistente           | password     |
      | noexiste@gmail.com          | AnyPass123   |
      | usuario.falso@outlook.com   | TestPass456  |
      | invalido@yahoo.com          | WrongPwd789  |

  Scenario Outline: Validación de campos vacíos en el formulario de login
    Given estoy en la página de inicio de sesión
    When dejo el campo "<campo_vacio>" sin completar
    And hago clic en el botón "Iniciar Sesión"
    Then debo ver un mensaje de error "<mensaje_error>"
    And no debo ser autenticado
    
    Examples:
      | campo_vacio | mensaje_error                           |
      | email       | El correo electrónico es obligatorio    |
      | password    | La contraseña es obligatoria            |

  Scenario: Bloqueo de cuenta después de múltiples intentos fallidos
    Given existe un usuario registrado con email "juan.perez@gmail.com"
    And estoy en la página de inicio de sesión
    When ingreso el email "juan.perez@gmail.com"
    And ingreso una contraseña incorrecta 5 veces consecutivas
    Then debo ver un mensaje de error "Cuenta bloqueada temporalmente por múltiples intentos fallidos"
    And la cuenta debe quedar bloqueada por 15 minutos
    And debo recibir un correo de notificación de bloqueo

  Scenario: Cierre de sesión exitoso
    Given he iniciado sesión exitosamente como "juan.perez@gmail.com"
    And estoy en mi dashboard
    When hago clic en el botón "Cerrar Sesión"
    Then mi sesión debe ser cerrada correctamente
    And debo ser redirigido a la página de inicio de sesión
    And no debo poder acceder a páginas protegidas sin autenticarme nuevamente

  Scenario: Persistencia de sesión con "Recordarme"
    Given estoy en la página de inicio de sesión
    When ingreso credenciales válidas
    And marco la opción "Recordarme"
    And hago clic en el botón "Iniciar Sesión"
    Then mi sesión debe persistir por 30 días
    And no debo necesitar ingresar credenciales nuevamente durante ese período