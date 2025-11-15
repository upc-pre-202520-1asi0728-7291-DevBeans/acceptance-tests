# Archivo: us13_analisis_color_uniformidad.feature
# User Story ID: US13
# Título: Análisis de Color y Uniformidad
# Épico: EP03 - Clasificación Automática de Granos

Feature: Medición Objetiva de Parámetros Físicos del Grano
  Como productor o cooperativa
  Quiero medir objetivamente color y tamaño
  Para estandarizar la calidad entre lotes

  Background:
    Given el sistema BeanDetect AI está disponible
    And el módulo de análisis está activo

  Scenario: Estandarización de la calidad entre lotes
    Given un lote de café de diferentes productores asociados está siendo clasificado
    When el sistema realiza el análisis automático
    Then el sistema debe medir objetivamente el color y el tamaño de los granos para estandarizar la calidad entre los lotes

  Scenario Outline: Análisis de distribución de color
    Given tengo un lote "<codigo_lote>" para analizar
    When el sistema procesa la imagen
    Then debe reportar porcentajes de color: Light "<light>%", Medium "<medium>%", Dark "<dark>%", Green "<green>%"
    And la suma de porcentajes debe ser aproximadamente 100%
    
    Examples:
      | codigo_lote   | light | medium | dark | green |
      | LOT-2024-0001 | 80    | 15     | 3    | 2     |
      | LOT-2024-0002 | 20    | 60     | 15   | 5     |
      | LOT-2024-0003 | 5     | 85     | 5    | 5     |