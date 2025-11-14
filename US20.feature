# Archivo: us20_codigos_qr_para_lotes.feature
# User Story ID: US20
# Título: Códigos QR para Lotes
# Épico: EP05 - Integración de certificados de trazabilidad

Feature: Generación de Identificadores Únicos para Trazabilidad

  Scenario: Verificación de origen y calidad por parte de compradores
    Given soy un productor o cooperativa
    And un lote de café ha sido clasificado y registrado
    When solicito la generación de un código QR único para ese lote
    Then el código QR generado debe permitir a los compradores verificar fácilmente el origen, la calidad y el proceso de clasificación