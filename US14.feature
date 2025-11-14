# Archivo: us14_clasificacion_estandares_internacionales.feature
# User Story ID: US14
# Título: Clasificación por Estándares Internacionales
# Épico: EP03 - Clasificación Automática de Granos

Feature: Cumplimiento de Normativas de Exportación

  Scenario: Obtención de clasificación para acceder a mejores precios
    Given un lote de café ha completado exitosamente la detección de defectos y el análisis físico
    When solicito la clasificación final del lote según estándares de exportación reconocidos
    Then el sistema debe entregar una clasificación automática que me permita acceder a mejores precios en el mercado internacional