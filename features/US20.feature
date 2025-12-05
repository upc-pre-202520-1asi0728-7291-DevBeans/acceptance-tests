# Archivo: us20_integracion_blockchain.feature
# User Story ID: US20
# Título: Integración con Blockchain
# Épico: EP04 - Reportes y Análisis

Feature: Registro de Clasificaciones en Blockchain para Transparencia
  Como cooperativa innovadora
  Quiero la opción de registrar datos de clasificación en blockchain
  Para mayor transparencia y confianza del mercado

  Background:
    Given soy una cooperativa y he iniciado sesión
    And tengo habilitada la opción de integración con blockchain

  Scenario: Registro para mayor transparencia y confianza
    Given tengo un lote de café clasificado
    When registro los datos de clasificación en blockchain
    Then debe generarse un registro inmutable y verificable
    And esto debe proporcionar mayor transparencia y confianza a mis compradores

  Scenario: Inmutabilidad de los registros
    Given he registrado una clasificación en blockchain
    When intento modificar los datos del registro
    Then el sistema debe impedir cualquier modificación
    And el registro original debe permanecer intacto
    And debe confirmarse que el registro es inmutable

  Scenario: Verificabilidad de registros
    Given tengo un registro de clasificación en blockchain
    When un comprador solicita verificar el registro
    Then debe poder confirmar la autenticidad de los datos
    And debe mostrarse el hash único del registro
    And debe indicarse la fecha y hora del registro

  Scenario: Generación de hash único por registro
    Given tengo 3 clasificaciones diferentes
    When registro cada una en blockchain
    Then cada registro debe tener un hash SHA-256 único
    And ningún hash debe repetirse
    And los hashes deben ser verificables

  Scenario: Verificación de integridad de datos
    Given tengo registros en blockchain
    When solicito verificar la integridad de la cadena
    Then debe confirmarse que todos los registros son válidos
    And debe calcularse el porcentaje de integridad
    And no deben detectarse registros alterados

  Scenario: Trazabilidad completa del lote
    Given tengo el lote "LOT-2024-0156" con múltiples eventos registrados
    When solicito el reporte de trazabilidad blockchain
    Then debe mostrarse toda la historia del lote
    And cada evento debe tener su hash y timestamp
    And debe confirmarse la trazabilidad completa

  Scenario: Cadena de bloques correctamente enlazada
    Given tengo múltiples registros en blockchain
    When verifico la estructura de la cadena
    Then cada bloque debe referenciar al bloque anterior
    And el primer bloque debe tener hash "GENESIS"
    And la cadena debe estar correctamente enlazada

  Scenario Outline: Registro de diferentes tipos de eventos
    Given tengo el lote "<lote>" con un evento de tipo "<evento>"
    When registro el evento en blockchain
    Then debe crearse un registro con el tipo "<evento>"
    And debe incluir los datos específicos del evento
    And debe asignarse un identificador único
    
    Examples:
      | lote          | evento         |
      | LOT-2024-0156 | CLASIFICACION  |
      | LOT-2024-0156 | CERTIFICACION  |
      | LOT-2024-0157 | EXPORTACION    |

  Scenario: Score de transparencia
    Given tengo múltiples registros en blockchain
    When calculo el score de transparencia
    Then debe mostrarse un porcentaje de transparencia
    And un 100% indica cadena completamente válida
    And debe basarse en la integridad de todos los registros

  Scenario: URL de verificación pública
    Given he registrado datos en blockchain
    When genero el certificado blockchain
    Then debe incluir una URL de verificación pública
    And cualquier persona debe poder verificar el registro
    And no debe requerir autenticación para verificar

