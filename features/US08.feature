# Archivo: us08_visualizacion_lotes_productor.feature
# User Story ID: US08
# Título: Visualización de Lotes por Productor
# Épico: EP02 - Gestión de Lotes de Café

Feature: Vista Simple del Histórico de Producción Individual
  Como productor
  Quiero ver todos mis lotes en una vista simple
  Para revisar mi histórico de producción sin complejidad técnica

  Background:
    Given el sistema BeanDetect AI está disponible
    And he iniciado sesión como productor

  Scenario: Revisión del histórico de producción por el productor
    Given soy un productor y he iniciado sesión
    And tengo varios lotes registrados a mi nombre
    When accedo a la sección para ver mis lotes
    Then el sistema debe mostrarme todos mis lotes en una vista simple y fácil de entender, sin complejidad técnica

  Scenario Outline: Visualización de lotes con diferentes cantidades
    Given soy un productor con ID "<productor_id>"
    And tengo "<cantidad_lotes>" lotes registrados
    When accedo a "Mis Lotes"
    Then debo ver exactamente "<cantidad_lotes>" lotes en la lista
    And cada lote debe mostrar: código, fecha de cosecha, variedad, cantidad, estado
    
    Examples:
      | productor_id | cantidad_lotes |
      | 1            | 3              |
      | 2            | 5              |
      | 3            | 1              |
      | 4            | 10             |

  Scenario Outline: Filtrado de lotes por estado
    Given tengo múltiples lotes en diferentes estados
    When filtro mis lotes por estado "<estado>"
    Then debo ver solo los lotes con estado "<estado>"
    And el contador debe mostrar "<cantidad>" lotes
    
    Examples:
      | estado      | cantidad |
      | REGISTERED  | 3        |
      | PROCESSING  | 2        |
      | CLASSIFIED  | 4        |
      | CERTIFIED   | 1        |

  Scenario Outline: Filtrado de lotes por año de cosecha
    Given tengo lotes de diferentes años de cosecha
    When filtro mis lotes por año "<año>"
    Then debo ver solo los lotes cosechados en "<año>"
    And cada lote mostrado debe tener fecha de cosecha en el año "<año>"
    
    Examples:
      | año  |
      | 2023 |
      | 2024 |
      | 2025 |

  Scenario: Ordenamiento de lotes por fecha de cosecha
    Given tengo 5 lotes registrados
    When accedo a "Mis Lotes"
    And selecciono ordenar por "Fecha de Cosecha - Más reciente"
    Then los lotes deben mostrarse ordenados del más reciente al más antiguo
    And el primer lote debe ser el de fecha más reciente

  Scenario Outline: Búsqueda rápida de lotes por código
    Given tengo múltiples lotes registrados
    When ingreso "<codigo_busqueda>" en el campo de búsqueda
    Then debo ver los lotes que coincidan con "<codigo_busqueda>"
    And debo ver "<resultado_esperado>"
    
    Examples:
      | codigo_busqueda | resultado_esperado                           |
      | LOT-2024-0001   | Exactamente 1 lote: LOT-2024-0001            |
      | LOT-2024        | Todos los lotes del año 2024                 |
      | XXXX            | Mensaje: No se encontraron lotes             |

  Scenario: Visualización de resumen estadístico
    Given tengo 10 lotes registrados en diferentes estados
    When accedo a "Mis Lotes"
    Then debo ver un resumen con:
      | Total de lotes                    | 10              |
      | Lotes en proceso de clasificación | 3               |
      | Lotes clasificados                | 5               |
      | Lotes certificados                | 2               |
      | Kilogramos totales                | 4500 kg         |

  Scenario: Vista de detalles de un lote específico
    Given tengo el lote "LOT-2024-0001" registrado
    When hago clic en "Ver Detalles" del lote "LOT-2024-0001"
    Then debo ver toda la información del lote incluyendo:
      | Código de lote           | LOT-2024-0001    |
      | Fecha de cosecha         | 15/05/2024       |
      | Variedad                 | TYPICA           |
      | Cantidad                 | 500 kg           |
      | Estado                   | CLASSIFIED       |
      | Método de procesamiento  | WASHED           |
      | Ubicación                | Cusco, Perú      |

  Scenario: Paginación de lista de lotes
    Given tengo 25 lotes registrados
    And la configuración de paginación es 10 lotes por página
    When accedo a "Mis Lotes"
    Then debo ver los primeros 10 lotes
    And debo ver controles de paginación "1 2 3"
    When hago clic en "Página 2"
    Then debo ver los lotes 11 al 20

  Scenario: Exportación de lista de lotes a CSV
    Given tengo múltiples lotes registrados
    When accedo a "Mis Lotes"
    And hago clic en "Exportar a CSV"
    Then debe descargarse un archivo CSV con todos mis lotes
    And el archivo debe contener las columnas: Código, Fecha, Variedad, Cantidad, Estado

  Scenario: Vista responsive en dispositivos móviles
    Given accedo a "Mis Lotes" desde un dispositivo móvil
    Then la lista de lotes debe adaptarse al tamaño de pantalla
    And la información debe ser fácilmente legible
    And los controles deben ser accesibles con el dedo