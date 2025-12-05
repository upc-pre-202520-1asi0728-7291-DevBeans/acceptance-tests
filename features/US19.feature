# Archivo: us19_codigos_qr_lotes.feature
# User Story ID: US19
# Título: Códigos QR para Lotes
# Épico: EP04 - Reportes y Análisis

Feature: Generación de Códigos QR para Verificación de Lotes
  Como productor o cooperativa
  Quiero generar códigos QR únicos por lote
  Para que compradores puedan verificar origen, calidad y proceso de clasificación

  Background:
    Given soy un productor o cooperativa y he iniciado sesión
    And tengo un lote clasificado exitosamente

  Scenario: Verificación de origen y calidad por compradores
    Given tengo un lote de café clasificado
    When genero un código QR para el lote
    Then los compradores deben poder escanear el QR
    And verificar el origen, calidad y proceso de clasificación del lote

  Scenario: Generación de código QR único por lote
    Given tengo el lote "LOT-2024-0156"
    And tengo el lote "LOT-2024-0157"
    When genero códigos QR para ambos lotes
    Then cada lote debe tener un código QR único
    And los códigos QR no deben ser iguales

  Scenario: Información de origen en el código QR
    Given tengo un lote del productor "Cooperativa Café Alto" de "Cusco, Perú"
    When genero el código QR
    Then el QR debe contener la información del origen
    And debe incluir el nombre del productor
    And debe incluir la fecha de cosecha

  Scenario: Información de calidad en el código QR
    Given tengo un lote con calidad 87.5% y grado "SPECIALTY"
    When genero el código QR
    Then el QR debe contener la puntuación de calidad
    And debe incluir el grado asignado
    And debe incluir el número de granos analizados

  Scenario: Verificación del proceso de clasificación
    Given tengo un código QR generado para un lote
    When un comprador escanea el QR
    Then debe poder verificar que la clasificación fue realizada
    And debe mostrarse la fecha de clasificación
    And debe confirmarse que los datos son auténticos

  Scenario: URL de verificación en el código QR
    Given genero un código QR para el lote "LOT-2024-0156"
    When examino el contenido del QR
    Then debe incluir una URL de verificación válida
    And la URL debe ser del dominio de BeanDetect AI
    And debe contener el identificador único del lote

  Scenario: Código QR escaneable y válido
    Given he generado un código QR
    When verifico las propiedades del QR
    Then debe ser escaneable por cualquier lector de QR
    And debe contener datos válidos en formato estándar
    And debe estar listo para impresión

  Scenario Outline: Verificación de QR por diferentes compradores
    Given tengo el lote "<lote>" con código QR generado
    When el comprador "<comprador>" escanea el código QR
    Then debe ver la información completa del lote
    And debe confirmar que el origen es "<origen>"
    And debe ver la calidad "<calidad>"
    
    Examples:
      | lote          | comprador       | origen       | calidad |
      | LOT-2024-0156 | Café Europa     | Cusco, Perú  | 87.5%   |
      | LOT-2024-0157 | Tostadores USA  | Cajamarca    | 72.0%   |

  Scenario: QR listo para impresión en etiquetas
    Given he generado un código QR
    When solicito el formato para impresión
    Then debe proporcionarse la imagen en alta resolución
    And debe incluir el tamaño recomendado (5cm x 5cm)
    And debe estar en formato PNG o SVG

