# Archivo: us13_analisis_color_uniformidad.feature
# User Story ID: US13
# Título: Análisis de Color y Uniformidad
# Épico: EP03 - Clasificación Automática de Granos

Feature: Medición Objetiva de Parámetros Físicos del Grano

  Scenario: Estandarización de la calidad entre lotes
    Given un lote de café de diferentes productores asociados está siendo clasificado
    When el sistema realiza el análisis automático
    Then el sistema debe medir objetivamente el color y el tamaño de los granos para estandarizar la calidad entre los lotes