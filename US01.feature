# Archivo: us01_registro_productor.feature
# User Story ID: US01
# Título: Registro de Productor Pequeño/Mediano
# Épico: EP01 - Gestión de Usuarios

Feature: Registro de Productor Pequeño/Mediano

  Scenario: Registro exitoso de un productor con datos de finca
    Given soy un productor de café pequeño o mediano
    And he completado el formulario de registro con información básica de mi finca (ubicación, hectáreas)
    When envío mi solicitud de registro a BeanDetect AI
    Then debo recibir una confirmación de registro y obtener credenciales de acceso para la tecnología de clasificación