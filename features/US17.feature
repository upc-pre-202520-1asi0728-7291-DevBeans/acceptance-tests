# Archivo: us17_exportacion_compradores.feature
# User Story ID: US17
# Título: Exportación para Compradores
# Épico: EP04 - Reportes y Análisis

Feature: Exportación de Certificados de Calidad en Formatos Internacionales
  Como productor o cooperativa
  Quiero exportar certificados de calidad en formatos reconocidos internacionalmente (PDF, Excel)
  Para presentar a compradores y facilitar transacciones comerciales

  Background:
    Given soy un productor o cooperativa y he iniciado sesión
    And tengo un lote con clasificación completada

  Scenario: Generación de certificado para presentar a compradores
    Given tengo un lote de café clasificado exitosamente
    When solicito exportar el certificado de calidad
    Then debo poder generar un documento en formato reconocido internacionalmente
    And el certificado debe ser válido para presentar a compradores nacionales e internacionales

  Scenario: Exportación de certificado en formato PDF
    Given tengo un lote clasificado con categoría "SPECIALTY"
    When solicito el certificado en formato PDF
    Then debe generarse un archivo PDF descargable
    And el PDF debe incluir el logo de BeanDetect AI
    And debe incluir información del lote, productor y calidad
    And debe cumplir con estándares internacionales ICO

  Scenario: Exportación de reporte en formato Excel
    Given tengo un lote clasificado con datos detallados
    When solicito el reporte en formato Excel
    Then debe generarse un archivo XLSX descargable
    And debe contener múltiples hojas con información organizada
    And debe incluir una hoja de resumen y una de detalle de calidad

  Scenario Outline: Validación de información en certificados
    Given tengo un lote "<lote>" del productor "<productor>"
    And la calidad es "<calidad>" con grado "<grado>"
    When genero el certificado de exportación
    Then el certificado debe mostrar el número de lote "<lote>"
    And debe mostrar el nombre del productor "<productor>"
    And debe mostrar la puntuación de calidad "<calidad>"
    And debe mostrar el grado asignado "<grado>"
    
    Examples:
      | lote          | productor              | calidad | grado     |
      | LOT-2024-0156 | Cooperativa Café Alto  | 87.5%   | SPECIALTY |
      | LOT-2024-0157 | Finca El Cafetal       | 72.0%   | STANDARD  |

  Scenario: Certificado incluye equivalencia SCA
    Given tengo un lote con puntuación de calidad de 87%
    When genero el certificado PDF
    Then debe incluir la equivalencia según estándares SCA
    And debe indicar "Specialty Grade (85+)" como clasificación SCA

  Scenario: Verificación de formato reconocido internacionalmente
    Given he generado un certificado PDF
    When verifico el contenido del certificado
    Then debe incluir un número de certificado único
    And debe incluir la URL de verificación online
    And debe indicar el estándar internacional cumplido

