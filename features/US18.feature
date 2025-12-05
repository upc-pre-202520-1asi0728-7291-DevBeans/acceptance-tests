# Archivo: us18_comparacion_historica_calidad.feature
# User Story ID: US18
# Título: Comparación Histórica de Calidad
# Épico: EP04 - Reportes y Análisis

Feature: Comparación de Calidad por Temporadas para Mejora Continua
  Como cooperativa
  Quiero comparar calidad por temporadas
  Para identificar patrones y mejorar prácticas agrícolas de mis asociados

  Background:
    Given soy una cooperativa y he iniciado sesión
    And tengo datos históricos de múltiples temporadas de cosecha

  Scenario: Identificación de patrones para mejorar prácticas agrícolas
    Given tengo datos de clasificación de al menos 3 temporadas
    When genero el reporte de comparación histórica
    Then debo poder identificar patrones de calidad a lo largo del tiempo
    And el sistema debe proporcionar insights para mejorar las prácticas agrícolas de mis asociados

  Scenario: Detección de tendencia de mejora
    Given tengo las siguientes temporadas con calidad promedio:
      | temporada     | calidad |
      | Cosecha 2022  | 72%     |
      | Cosecha 2023  | 78%     |
      | Cosecha 2024  | 83%     |
    When analizo la tendencia histórica
    Then debe indicarse una tendencia "MEJORANDO"
    And debe calcularse el porcentaje de mejora desde la primera temporada

  Scenario: Detección de tendencia de deterioro
    Given tengo temporadas con calidad decreciente
    When analizo la tendencia histórica
    Then debe indicarse una tendencia "EN DECLIVE"
    And deben generarse alertas sobre el deterioro
    And deben sugerirse acciones correctivas

  Scenario: Comparación año a año (Year over Year)
    Given tengo datos de 3 temporadas consecutivas
    When solicito el análisis año a año
    Then debe mostrarse el cambio de calidad entre cada temporada
    And debe indicarse si cada cambio fue positivo o negativo

  Scenario Outline: Filtrado por período específico
    Given tengo datos desde 2020 hasta 2024
    When filtro el reporte desde "<inicio>" hasta "<fin>"
    Then solo deben incluirse las temporadas dentro del período
    And debe recalcularse la tendencia para ese período
    
    Examples:
      | inicio     | fin        |
      | 2022-01-01 | 2023-12-31 |
      | 2023-01-01 | 2024-12-31 |

  Scenario: Identificación de alta variabilidad
    Given tengo temporadas con calidad muy variable (diferencia mayor a 20%)
    When genero el análisis histórico
    Then debe identificarse un patrón de "ALTA VARIABILIDAD"
    And debe sugerirse estandarizar procesos de cosecha y fermentación

  Scenario: Generación de insights agrícolas
    Given tengo suficientes datos históricos
    When solicito el reporte con insights
    Then deben generarse recomendaciones específicas
    And deben identificarse las mejores temporadas
    And deben sugerirse prácticas a replicar

  Scenario: Identificación de mejor temporada
    Given tengo datos de múltiples temporadas
    When analizo el histórico
    Then debe identificarse la temporada con mejor calidad
    And debe sugerirse documentar las condiciones de esa temporada

