# Archivo: us07_edicion_informacion_lote.feature
# User Story ID: US07
# Título: Edición de Información de Lote
# Épico: EP02 - Gestión de Lotes de Café

Feature: Modificación de Datos de Lotes Existentes
  Como usuario (productor o cooperativa)
  Quiero editar información de mis lotes
  Para corregir errores o actualizar cambios en la información de cosecha

  Background:
    Given el sistema BeanDetect AI está disponible
    And he iniciado sesión en el sistema
    And tengo al menos un lote registrado

  Scenario: Corrección de errores en la información del lote
    Given tengo un lote de café registrado en el sistema
    And he detectado un error o un cambio en su información (e.g., corregir la variedad)
    When accedo a la opción de edición y guardo los nuevos datos del lote
    Then la información del lote debe ser actualizada correctamente en la base de datos

  Scenario Outline: Actualización exitosa de diferentes campos del lote
    Given tengo un lote registrado con código "<codigo_lote>"
    And estoy en la vista de detalles del lote
    When hago clic en "Editar Lote"
    And actualizo el campo "<campo>" con el nuevo valor "<nuevo_valor>"
    And hago clic en "Guardar Cambios"
    Then debo ver un mensaje "Lote actualizado exitosamente"
    And el campo "<campo>" debe mostrar el nuevo valor "<nuevo_valor>"
    And el código del lote no debe cambiar
    
    Examples:
      | codigo_lote   | campo                | nuevo_valor    |
      | LOT-2024-0001 | cantidad             | 600            |
      | LOT-2024-0002 | metodo_procesamiento | HONEY          |
      | LOT-2024-0003 | altitud              | 1750           |
      | LOT-2024-0004 | tipo_suelo           | Clay           |
      | LOT-2024-0005 | zona_climatica       | Subtropical    |

  Scenario Outline: Validación de restricciones en la edición de lotes
    Given tengo un lote registrado con estado "<estado_lote>"
    When intento editar la información del lote
    Then "<resultado_accion>"
    
    Examples:
      | estado_lote | resultado_accion                                                     |
      | REGISTERED  | debo poder editar todos los campos editables del lote                |
      | PROCESSING  | debo poder editar algunos campos pero no la información básica       |
      | CLASSIFIED  | debo ver un mensaje "No se puede editar un lote ya clasificado"      |
      | CERTIFIED   | debo ver un mensaje "No se puede editar un lote certificado"         |
      | SHIPPED     | debo ver un mensaje "No se puede editar un lote ya despachado"       |

  Scenario: Protección de campos críticos en lotes clasificados
    Given tengo un lote con código "LOT-2024-0001" en estado "CLASSIFIED"
    When intento acceder a la opción de edición
    Then debo ver un mensaje informativo "Este lote ya ha sido clasificado y no puede ser editado"
    And el botón "Editar Lote" debe estar deshabilitado
    And debo ver la opción "Solicitar Modificación Especial" para casos excepcionales

  Scenario Outline: Validación de valores numéricos en la edición
    Given tengo un lote registrado con código "LOT-2024-0001"
    And estoy en modo de edición del lote
    When intento actualizar el campo "<campo_numerico>" con "<valor_invalido>"
    And hago clic en "Guardar Cambios"
    Then debo ver un mensaje de error "<mensaje_error>"
    And los cambios no deben guardarse
    
    Examples:
      | campo_numerico | valor_invalido | mensaje_error                                    |
      | cantidad       | -100           | La cantidad debe ser un valor positivo           |
      | cantidad       | 0              | La cantidad debe ser mayor a cero                |
      | altitud        | -500           | La altitud debe ser un valor positivo            |
      | altitud        | 6000           | La altitud no puede superar los 5000 metros      |

  Scenario: Confirmación antes de guardar cambios importantes
    Given tengo un lote registrado con código "LOT-2024-0001"
    And estoy editando el método de procesamiento de "WASHED" a "NATURAL"
    When hago clic en "Guardar Cambios"
    Then debo ver un diálogo de confirmación "¿Está seguro de cambiar el método de procesamiento?"
    When confirmo los cambios
    Then los cambios deben guardarse correctamente
    And debo ver un mensaje "Lote actualizado exitosamente"

  Scenario: Cancelación de edición sin guardar cambios
    Given tengo un lote registrado con código "LOT-2024-0001"
    And estoy en modo de edición del lote
    And he modificado varios campos
    When hago clic en "Cancelar"
    Then los cambios no deben guardarse
    And debo volver a la vista de detalles del lote con la información original
    And debo ver un mensaje "Cambios descartados"

  Scenario: Historial de modificaciones del lote
    Given tengo un lote registrado con código "LOT-2024-0001"
    When accedo a la vista de detalles del lote
    And hago clic en "Ver Historial de Cambios"
    Then debo ver una lista de todas las modificaciones realizadas al lote
    And cada modificación debe mostrar: fecha, usuario, campo modificado, valor anterior, valor nuevo
    And las modificaciones deben estar ordenadas por fecha descendente

  Scenario: Notificación de cambios a usuarios relevantes
    Given soy una cooperativa
    And tengo un lote registrado por un productor asociado
    When el productor edita información del lote
    Then debo recibir una notificación de la modificación realizada
    And la notificación debe incluir: código del lote, fecha, campos modificados

  Scenario Outline: Validación de coordenadas geográficas en la edición
    Given tengo un lote registrado con código "LOT-2024-0001"
    And estoy editando la ubicación del lote
    When intento actualizar latitud a "<latitud>" y longitud a "<longitud>"
    And hago clic en "Guardar Cambios"
    Then debo ver el resultado "<resultado>"
    
    Examples:
      | latitud   | longitud  | resultado                                                   |
      | -12.5000  | -77.0500  | Lote actualizado exitosamente                               |
      | 95.0000   | -77.0500  | Error: La latitud debe estar entre -90 y 90 grados          |
      | -12.5000  | 185.0000  | Error: La longitud debe estar entre -180 y 180 grados       |