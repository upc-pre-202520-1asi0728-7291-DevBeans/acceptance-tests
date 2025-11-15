# Archivo: us06_creacion_lotes.feature
# User Story ID: US06
# Título: Creación de Lotes
# Épico: EP02 - Gestión de Lotes de Café

Feature: Registro de Nuevos Lotes de Café
  Como usuario (productor o cooperativa)
  Quiero registrar nuevos lotes de café
  Para organizar mi producción de forma eficiente

  Background:
    Given el sistema BeanDetect AI está disponible
    And he iniciado sesión en el sistema

  Scenario: Registro exitoso de un lote con información básica
    Given soy un usuario (productor o cooperativa) y he iniciado sesión
    When registro un nuevo lote de café completando la información básica requerida (fecha de cosecha, variedad, origen)
    Then el lote debe ser creado en mi inventario, permitiéndome organizar mi producción de forma eficiente

  Scenario Outline: Registro de lotes con diferentes características
    Given estoy en la sección de "Gestión de Lotes"
    And hago clic en "Registrar Nuevo Lote"
    When ingreso la fecha de cosecha "<fecha_cosecha>"
    And selecciono la variedad de café "<variedad>"
    And ingreso la cantidad en kilogramos "<cantidad>"
    And selecciono el método de procesamiento "<metodo_procesamiento>"
    And ingreso la ubicación con latitud "<latitud>" y longitud "<longitud>"
    And ingreso la altitud "<altitud>" metros
    And hago clic en "Registrar Lote"
    Then debo ver un mensaje "Lote registrado exitosamente"
    And se debe generar un código único de lote "<codigo_esperado>"
    And el lote debe aparecer en mi lista de lotes
    
    Examples:
      | fecha_cosecha | variedad | cantidad | metodo_procesamiento | latitud    | longitud   | altitud | codigo_esperado |
      | 2024-05-15    | TYPICA   | 500      | WASHED               | -12.0464   | -77.0428   | 1500    | LOT-2024-0001   |
      | 2024-06-20    | CATURRA  | 300      | NATURAL              | -13.5320   | -71.9675   | 1800    | LOT-2024-0002   |
      | 2024-07-10    | BOURBON  | 450      | HONEY                | -11.8765   | -77.0950   | 1600    | LOT-2024-0003   |
      | 2024-08-05    | GEISHA   | 200      | WASHED               | -12.3456   | -76.8765   | 2000    | LOT-2024-0004   |

  Scenario Outline: Validación de campos obligatorios en el registro de lotes
    Given estoy en el formulario de "Registrar Nuevo Lote"
    When dejo el campo "<campo_obligatorio>" sin completar
    And hago clic en "Registrar Lote"
    Then debo ver un mensaje de error "<mensaje_error>"
    And el lote no debe ser registrado
    
    Examples:
      | campo_obligatorio      | mensaje_error                                    |
      | fecha_cosecha          | La fecha de cosecha es obligatoria               |
      | variedad               | La variedad de café es obligatoria               |
      | cantidad               | La cantidad en kilogramos es obligatoria         |
      | metodo_procesamiento   | El método de procesamiento es obligatorio        |
      | latitud                | La latitud es obligatoria                        |
      | longitud               | La longitud es obligatoria                       |

  Scenario Outline: Validación de formato de coordenadas geográficas
    Given estoy en el formulario de "Registrar Nuevo Lote"
    When ingreso una latitud inválida "<latitud_invalida>"
    Or ingreso una longitud inválida "<longitud_invalida>"
    And hago clic en "Registrar Lote"
    Then debo ver un mensaje de error "<mensaje_error>"
    And el lote no debe ser registrado
    
    Examples:
      | latitud_invalida | longitud_invalida | mensaje_error                                        |
      | 95.0000          | -77.0428          | La latitud debe estar entre -90 y 90 grados          |
      | -12.0464         | 185.0000          | La longitud debe estar entre -180 y 180 grados       |
      | ABC              | -77.0428          | La latitud debe ser un valor numérico válido         |
      | -12.0464         | XYZ               | La longitud debe ser un valor numérico válido        |

  Scenario: Validación de fecha de cosecha no futura
    Given estoy en el formulario de "Registrar Nuevo Lote"
    When ingreso una fecha de cosecha futura "2025-12-31"
    And completo todos los demás campos correctamente
    And hago clic en "Registrar Lote"
    Then debo ver un mensaje de error "La fecha de cosecha no puede ser futura"
    And el lote no debe ser registrado

  Scenario Outline: Registro de lotes con información opcional adicional
    Given estoy en el formulario de "Registrar Nuevo Lote"
    When completo todos los campos obligatorios
    And agrego información opcional: tipo de suelo "<tipo_suelo>"
    And agrego información opcional: zona climática "<zona_climatica>"
    And agrego información opcional: sección de finca "<seccion_finca>"
    And hago clic en "Registrar Lote"
    Then el lote debe registrarse con toda la información completa
    And debo poder ver la información adicional en los detalles del lote
    
    Examples:
      | tipo_suelo | zona_climatica | seccion_finca  |
      | Volcanic   | Tropical       | Sector Norte   |
      | Clay       | Subtropical    | Zona Alta      |
      | Sandy      | Temperate      | Parcela 3      |

  Scenario: Generación automática de número de lote único
    Given he registrado 3 lotes en el año 2024
    When registro un nuevo lote
    Then el sistema debe generar automáticamente el código "LOT-2024-0004"
    And el código debe ser único en todo el sistema
    And el código debe seguir el formato "LOT-YYYY-NNNN"

  Scenario: Confirmación visual después del registro exitoso
    Given estoy en el formulario de "Registrar Nuevo Lote"
    When completo todos los campos obligatorios correctamente
    And hago clic en "Registrar Lote"
    Then debo ver una confirmación visual con el código del lote generado
    And debo tener la opción de "Ver Detalles del Lote"
    And debo tener la opción de "Registrar Otro Lote"