# Archivo: us03_autenticacion_usuarios.feature
# User Story ID: US03
# Título: Autenticación de Usuarios
# Épico: EP01 - Gestión de Usuarios

Feature: Inicio de Sesión Seguro para Usuarios Registrados

  Scenario: Acceso seguro al sistema con credenciales correctas
    Given soy un usuario registrado (productor o cooperativa)
    And proporciono mi nombre de usuario y contraseña correctos
    When intento iniciar sesión en BeanDetect AI
    Then el sistema debe permitir mi acceso de forma segura y dirigir a la interfaz según mi perfil de usuario