# Archivo: us16_reporte_consolidado_cooperativas.feature
# User Story ID: US16
# Título: Reporte Consolidado para Cooperativas
# Épico: EP04 - Reportes y Análisis

Feature: Reporte Consolidado para Comparación entre Productores Asociados
  Como cooperativa
  Quiero reportes consolidados que comparen la calidad entre diferentes productores asociados
  Para optimizar procesos grupales y mejorar el rendimiento colectivo

  Background:
    Given soy una cooperativa y he iniciado sesión
    And tengo múltiples productores asociados con lotes clasificados

  Scenario: Comparación de calidad entre productores para optimización grupal
    Given soy una cooperativa con varios productores asociados
    When genero un reporte consolidado de todos mis productores
    Then debo obtener un reporte que compare la calidad entre los diferentes productores
    And debe permitirme identificar oportunidades de mejora en los procesos grupales

  Scenario: Generación de ranking de productores por calidad
    Given tengo al menos 3 productores asociados con clasificaciones
    When solicito el reporte consolidado de la cooperativa
    Then debe mostrarse un ranking de productores ordenado por calidad promedio
    And debe identificarse al mejor productor del período
    And debe identificarse al productor con menor desempeño

  Scenario: Estadísticas agregadas de la cooperativa
    Given tengo productores asociados con múltiples sesiones de clasificación
    When genero el reporte consolidado
    Then debe incluir el promedio de calidad de toda la cooperativa
    And debe mostrar el total de granos analizados
    And debe indicar el número de sesiones de clasificación realizadas

  Scenario Outline: Comparación específica entre dos productores
    Given tengo el productor "<productor1>" con calidad promedio "<calidad1>"
    And tengo el productor "<productor2>" con calidad promedio "<calidad2>"
    When comparo ambos productores en el reporte
    Then debe mostrarse la diferencia de calidad entre ambos
    And debe indicarse quién tiene mejor desempeño
    
    Examples:
      | productor1    | calidad1 | productor2     | calidad2 |
      | Juan Pérez    | 85%      | María García   | 78%      |
      | Carlos López  | 92%      | Ana Rodríguez  | 65%      |

  Scenario: Sugerencias de mejora basadas en el análisis
    Given tengo productores con diferentes niveles de calidad
    When genero el reporte consolidado
    Then debe incluir sugerencias de mejora personalizadas
    And las sugerencias deben basarse en las brechas de calidad identificadas

