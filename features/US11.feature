# Archivo: us11_eliminacion_lotes.feature
# User Story ID: US11
# Título: Eliminación de Lotes
# Épico: EP02 - Gestión de Lotes de Café

Feature: Mantenimiento de la Base de Datos mediante Eliminación de Lotes
  Como usuario (productor o cooperativa)
  Quiero eliminar lotes erróneos o duplicados
  Para mantener limpia mi base de datos de producción

  Background:
    Given el sistema BeanDetect AI está disponible
    And he iniciado sesión en el sistema

  Scenario: Eliminación de lotes erróneos o duplicados
    Given soy un usuario (productor o cooperativa) y he identificado un lote erróneo o duplicado
    When selecciono la opción de eliminar dicho lote y confirmo la acción
    Then el lote debe ser permanentemente removido de mi base de datos de producción para mantenerla limpia

  Scenario Outline: Validación de permisos para eliminar lotes según estado
    Given tengo un lote con código "<codigo_lote>" en estado "<estado>"
    When intento eliminar el lote
    Then debo ver "<resultado>"
    
    Examples:
      | codigo_lote   | estado      | resultado                                                        |
      | LOT-2024-0001 | REGISTERED  | Confirmación: ¿Está seguro de eliminar este lote?               |
      | LOT-2024-0002 | PROCESSING  | Error: No se puede eliminar un lote en procesamiento            |
      | LOT-2024-0003 | CLASSIFIED  | Error: No se puede eliminar un lote ya clasificado              |
      | LOT-2024-0004 | CERTIFIED   | Error: No se puede eliminar un lote certificado                 |

  Scenario: Confirmación doble antes de eliminar
    Given tengo un lote "LOT-2024-0001" en estado "REGISTERED"
    When hago clic en "Eliminar Lote"
    Then debo ver un diálogo de confirmación con el mensaje "¿Está seguro de que desea eliminar el lote LOT-2024-0001?"
    And debo tener las opciones "Cancelar" y "Confirmar Eliminación"
    When hago clic en "Confirmar Eliminación"
    Then debo ingresar la razón de eliminación
    And el lote debe ser eliminado permanentemente

  Scenario Outline: Registro en auditoría de eliminaciones
    Given tengo un lote "LOT-2024-0001" 
    When elimino el lote con razón "<razon_eliminacion>"
    Then el sistema debe registrar en auditoría:
      | Usuario              | <mi_usuario>        |
      | Fecha y hora         | <timestamp>         |
      | Lote eliminado       | LOT-2024-0001       |
      | Razón                | <razon_eliminacion> |
    
    Examples:
      | razon_eliminacion           |
      | Lote duplicado              |
      | Error en el registro        |
      | Información incorrecta      |