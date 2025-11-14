# Archivo: us04_gestion_perfil_productor.feature
# User Story ID: US04
# Título: Gestión de Perfil de Productor
# Épico: EP01 - Gestión de Usuarios

Feature: Mantenimiento del Perfil de Productor

  Scenario: Actualización de la información de la finca
    Given soy un productor pequeño/mediano y he iniciado sesión
    And necesito actualizar la información de mi finca (e.g., nuevas hectáreas o variedades de café)
    When edito y guardo los cambios en la sección de gestión de perfil
    Then la información de mi finca (ubicación, hectáreas, variedades) debe quedar actualizada en el sistema para personalizar mi experiencia