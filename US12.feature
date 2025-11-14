# Archivo: us12_deteccion_defectos_criticos.feature
# User Story ID: US12
# Título: Detección de Defectos Críticos
# Épico: EP03 - Clasificación Automática de Granos

Feature: Identificación de Defectos que Causan Rechazo Internacional

  Scenario: Prevención de pérdidas económicas por defectos
    Given un lote de café es ingresado en el sistema para clasificación automática
    When el motor de IA analiza los granos
    Then el sistema debe detectar y reportar la presencia y cantidad de defectos críticos para prevenir rechazos internacionales