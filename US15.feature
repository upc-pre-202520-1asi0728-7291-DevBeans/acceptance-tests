# Archivo: us15_reporte_simple_clasificacion.feature
# User Story ID: US15
# Título: Reporte Simple de Clasificación
# Épico: EP04 - Reportes y Análisis

Feature: Reporte de Calidad Fácil de Entender para Productores

  Scenario: Revisión rápida de la calidad del lote para toma de decisiones
    Given soy un productor y un lote ha sido clasificado
    When genero el reporte de clasificación de mi lote
    Then debo obtener un reporte simple y fácil de entender que muestre claramente el porcentaje de café apto para exportación versus el apto para mercado local