# Archivo: us14_clasificacion_estandares_internacionales.feature
# User Story ID: US14
# Título: Clasificación por Estándares Internacionales
# Épico: EP03 - Clasificación Automática de Granos

Feature: Cumplimiento de Normativas de Exportación
  Como productor o cooperativa
  Quiero obtener clasificación automática según estándares
  Para acceder a mejores precios en el mercado internacional

  Background:
    Given el sistema BeanDetect AI está disponible
    And el lote ha completado todos los análisis previos

  Scenario: Obtención de clasificación para acceder a mejores precios
    Given un lote de café ha completado exitosamente la detección de defectos y el análisis físico
    When solicito la clasificación final del lote según estándares de exportación reconocidos
    Then el sistema debe entregar una clasificación automática que me permita acceder a mejores precios en el mercado internacional

  Scenario Outline: Asignación de categorías según calidad
    Given tengo un lote con score de calidad "<score>"
    When el sistema calcula la clasificación final
    Then debe asignarse la categoría "<categoria>"
    And debe indicarse el mercado objetivo "<mercado>"
    
    Examples:
      | score | categoria | mercado                   |
      | 95    | Specialty | Exportación Premium       |
      | 85    | Premium   | Exportación               |
      | 75    | A         | Exportación/Local         |
      | 65    | B         | Mercado Local             |
      | 50    | C         | Procesamiento Industrial  |