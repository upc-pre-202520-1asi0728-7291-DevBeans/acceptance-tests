# Archivo: us08_visualizacion_lotes_productor.feature
# User Story ID: US08
# Título: Visualización de Lotes por Productor
# Épico: EP02 - Gestión de Lotes de Café

Feature: Vista Simple del Histórico de Producción Individual

  Scenario: Revisión del histórico de producción por el productor
    Given soy un productor y he iniciado sesión
    And tengo varios lotes registrados a mi nombre
    When accedo a la sección para ver mis lotes
    Then el sistema debe mostrarme todos mis lotes en una vista simple y fácil de entender, sin complejidad técnica