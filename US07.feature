# Archivo: us07_edicion_informacion_lote.feature
# User Story ID: US07
# Título: Edición de Información de Lote
# Épico: EP02 - Gestión de Lotes de Café

Feature: Modificación de Datos de Lotes Existentes

  Scenario: Corrección de errores en la información del lote
    Given tengo un lote de café registrado en el sistema
    And he detectado un error o un cambio en su información (e.g., corregir la variedad)
    When accedo a la opción de edición y guardo los nuevos datos del lote
    Then la información del lote debe ser actualizada correctamente en la base de datos