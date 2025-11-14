# Archivo: us06_creacion_lotes.feature
# User Story ID: US06
# Título: Creación de Lotes
# Épico: EP02 - Gestión de Lotes de Café

Feature: Registro de Nuevos Lotes de Café

  Scenario: Registro exitoso de un lote con información básica
    Given soy un usuario (productor o cooperativa) y he iniciado sesión
    When registro un nuevo lote de café completando la información básica requerida (fecha de cosecha, variedad, origen)
    Then el lote debe ser creado en mi inventario, permitiéndome organizar mi producción de forma eficiente