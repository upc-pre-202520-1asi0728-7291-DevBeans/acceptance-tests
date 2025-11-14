# Archivo: us10_busqueda_rapida_lotes.feature
# User Story ID: US10
# Título: Búsqueda Rápida de Lotes
# Épico: EP02 - Gestión de Lotes de Café

Feature: Funcionalidad de Búsqueda Rápida y Eficiente de Lotes

  Scenario: Acceso rápido a información de lotes mediante filtros
    Given soy un usuario (productor o cooperativa)
    And tengo un gran número de lotes registrados
    When utilizo la función de búsqueda ingresando criterios como fecha, productor (si soy cooperativa) o variedad
    Then el sistema debe filtrar y mostrarme rápidamente los lotes que coinciden con los criterios específicos