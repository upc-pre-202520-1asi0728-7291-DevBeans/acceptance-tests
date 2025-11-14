# Archivo: us11_eliminacion_lotes.feature
# User Story ID: US11
# Título: Eliminación de Lotes
# Épico: EP02 - Gestión de Lotes de Café

Feature: Mantenimiento de la Base de Datos mediante Eliminación de Lotes

  Scenario: Eliminación de lotes erróneos o duplicados
    Given soy un usuario (productor o cooperativa) y he identificado un lote erróneo o duplicado
    When selecciono la opción de eliminar dicho lote y confirmo la acción
    Then el lote debe ser permanentemente removido de mi base de datos de producción para mantenerla limpia