# Archivo: us02_registro_cooperativa.feature
# User Story ID: US02
# Título: Registro de Cooperativa Cafetalera
# Épico: EP01 - Gestión de Usuarios

Feature: Registro de Cooperativa Cafetalera

  Scenario: Registro exitoso de la organización cooperativa
    Given soy el administrador de una cooperativa cafetalera
    And tengo la información legal y operativa de la organización
    When registro mi organización en BeanDetect AI
    Then el sistema debe crear un perfil de cooperativa que me permita gestionar la clasificación de múltiples productores asociados