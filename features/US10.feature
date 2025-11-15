# Archivo: us10_busqueda_rapida_lotes.feature
# User Story ID: US10
# Título: Búsqueda Rápida de Lotes
# Épico: EP02 - Gestión de Lotes de Café

Feature: Funcionalidad de Búsqueda Rápida y Eficiente de Lotes
  Como usuario (productor o cooperativa)
  Quiero buscar lotes por diferentes criterios
  Para acceder rápidamente a información específica

  Background:
    Given el sistema BeanDetect AI está disponible
    And he iniciado sesión en el sistema

  Scenario: Acceso rápido a información de lotes mediante filtros
    Given soy un usuario (productor o cooperativa)
    And tengo un gran número de lotes registrados
    When utilizo la función de búsqueda ingresando criterios como fecha, productor (si soy cooperativa) o variedad
    Then el sistema debe filtrar y mostrarme rápidamente los lotes que coinciden con los criterios específicos

  Scenario Outline: Búsqueda por rango de fechas
    Given tengo lotes registrados entre enero y diciembre de 2024
    When busco lotes con fecha de cosecha entre "<fecha_inicio>" y "<fecha_fin>"
    Then debo ver "<cantidad>" lotes en los resultados
    And todos los lotes deben tener fecha de cosecha dentro del rango especificado
    
    Examples:
      | fecha_inicio | fecha_fin  | cantidad |
      | 2024-01-01   | 2024-03-31 | 5        |
      | 2024-04-01   | 2024-06-30 | 8        |
      | 2024-07-01   | 2024-09-30 | 6        |
      | 2024-10-01   | 2024-12-31 | 4        |

  Scenario Outline: Búsqueda por variedad de café
    Given tengo lotes de múltiples variedades
    When busco lotes de variedad "<variedad>"
    Then debo ver solo lotes de la variedad "<variedad>"
    And el resultado debe incluir "<cantidad>" lotes
    
    Examples:
      | variedad | cantidad |
      | TYPICA   | 7        |
      | CATURRA  | 5        |
      | BOURBON  | 4        |
      | GEISHA   | 2        |

  Scenario Outline: Búsqueda combinada con múltiples filtros
    Given tengo lotes con diferentes características
    When aplico los filtros: variedad "<variedad>", método "<metodo>", estado "<estado>"
    Then debo ver solo lotes que cumplan todos los criterios
    And el sistema debe mostrar "<resultado>"
    
    Examples:
      | variedad | metodo  | estado     | resultado                          |
      | TYPICA   | WASHED  | CLASSIFIED | 3 lotes encontrados                |
      | CATURRA  | NATURAL | REGISTERED | 2 lotes encontrados                |
      | GEISHA   | HONEY   | CERTIFIED  | 1 lote encontrado                  |