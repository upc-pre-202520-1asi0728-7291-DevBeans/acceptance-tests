# Archivo: us15_reporte_simple_clasificacion.feature
# User Story ID: US15
# Título: Reporte Simple de Clasificación
# Épico: EP04 - Reportes y Análisis

Feature: Reporte de Calidad Fácil de Entender para Productores
  Como productor
  Quiero un reporte simple de clasificación
  Para tomar decisiones rápidas sobre mi lote

  Background:
    Given soy un productor y he iniciado sesión
    And tengo un lote clasificado

  Scenario: Revisión rápida de la calidad del lote para toma de decisiones
    Given soy un productor y un lote ha sido clasificado
    When genero el reporte de clasificación de mi lote
    Then debo obtener un reporte simple y fácil de entender que muestre claramente el porcentaje de café apto para exportación versus el apto para mercado local

  Scenario Outline: Generación de reportes con diferentes formatos
    Given tengo un lote clasificado "<codigo_lote>"
    When solicito el reporte en formato "<formato>"
    Then debe generarse un archivo "<formato>" descargable
    And el reporte debe incluir: categoría, porcentajes, recomendaciones
    
    Examples:
      | codigo_lote   | formato |
      | LOT-2024-0001 | PDF     |
      | LOT-2024-0002 | CSV     |