# Archivo: us04_gestion_perfil_productor.feature
# User Story ID: US04
# Título: Gestión de Perfil de Productor
# Épico: EP01 - Gestión de Usuarios

Feature: Mantenimiento del Perfil de Productor
  Como productor pequeño/mediano
  Quiero actualizar la información de mi finca
  Para mantener mis datos al día y personalizar mi experiencia

  Background:
    Given el sistema BeanDetect AI está disponible
    And he iniciado sesión como productor

  Scenario: Actualización de la información de la finca
    Given soy un productor pequeño/mediano y he iniciado sesión
    And necesito actualizar la información de mi finca (e.g., nuevas hectáreas o variedades de café)
    When edito y guardo los cambios en la sección de gestión de perfil
    Then la información de mi finca (ubicación, hectáreas, variedades) debe quedar actualizada en el sistema para personalizar mi experiencia

  Scenario Outline: Actualización exitosa de diferentes campos del perfil
    Given estoy en la sección de "Gestión de Perfil"
    And mi perfil actual tiene la información inicial
    When actualizo el campo "<campo>" con el nuevo valor "<nuevo_valor>"
    And hago clic en "Guardar Cambios"
    Then debo ver un mensaje de confirmación "Perfil actualizado exitosamente"
    And el campo "<campo>" debe mostrar el nuevo valor "<nuevo_valor>"
    And debo recibir un correo de confirmación de actualización
    
    Examples:
      | campo              | nuevo_valor              |
      | hectareas          | 6.5                      |
      | ubicacion          | Valle Sagrado, Cusco     |
      | variedad_principal | GEISHA                   |
      | telefono           | +51 987 654 321          |
      | altitude           | 1800                     |
      | metodo_cultivo     | Orgánico                 |

  Scenario Outline: Actualización de información de contacto
    Given estoy en la sección de "Información de Contacto"
    When actualizo el teléfono a "<telefono>"
    And actualizo el email secundario a "<email_secundario>"
    And hago clic en "Guardar Cambios"
    Then la información de contacto debe actualizarse correctamente
    And debo recibir una confirmación en "<email_secundario>"
    
    Examples:
      | telefono         | email_secundario              |
      | +51 987 123 456  | juan.backup@gmail.com         |
      | +51 965 789 321  | maria.contacto@outlook.com    |
      | +51 912 345 678  | carlos.alt@yahoo.com          |

  Scenario Outline: Validación de campos numéricos en la actualización
    Given estoy en la sección de "Gestión de Perfil"
    When intento actualizar "<campo_numerico>" con un valor inválido "<valor_invalido>"
    And hago clic en "Guardar Cambios"
    Then debo ver un mensaje de error "<mensaje_error>"
    And los cambios no deben guardarse
    
    Examples:
      | campo_numerico | valor_invalido | mensaje_error                                      |
      | hectareas      | -5             | Las hectáreas deben ser un valor positivo          |
      | hectareas      | ABC            | Las hectáreas deben ser un número válido           |
      | altitude       | -100           | La altitud debe ser un valor positivo              |
      | altitude       | 9999           | La altitud debe estar entre 0 y 5000 metros        |

  Scenario: Actualización de variedades de café cultivadas
    Given estoy en la sección de "Variedades Cultivadas"
    And actualmente cultivo "TYPICA, CATURRA"
    When agrego la variedad "BOURBON" a mi lista
    And elimino la variedad "TYPICA" de mi lista
    And hago clic en "Guardar Cambios"
    Then mis variedades deben actualizarse a "CATURRA, BOURBON"
    And debo ver un mensaje "Variedades actualizadas exitosamente"

  Scenario: Actualización de foto de perfil
    Given estoy en la sección de "Gestión de Perfil"
    When subo una nueva foto de perfil en formato JPG de 2MB
    And hago clic en "Guardar Cambios"
    Then mi foto de perfil debe actualizarse correctamente
    And debo ver la nueva foto en el header del sistema

  Scenario Outline: Validación de formato de archivo para foto de perfil
    Given estoy en la sección de "Gestión de Perfil"
    When intento subir una foto con formato "<formato>" y tamaño "<tamaño>"
    Then debo ver un mensaje "<resultado>"
    
    Examples:
      | formato | tamaño | resultado                                                    |
      | JPG     | 1MB    | Foto de perfil actualizada exitosamente                      |
      | PNG     | 2MB    | Foto de perfil actualizada exitosamente                      |
      | PDF     | 1MB    | Formato no permitido. Use JPG, PNG o JPEG                    |
      | JPG     | 6MB    | El archivo es muy grande. El tamaño máximo es 5MB            |

  Scenario: Cancelación de cambios en el perfil
    Given estoy en la sección de "Gestión de Perfil"
    And he modificado varios campos del formulario
    When hago clic en "Cancelar"
    Then los cambios no deben guardarse
    And debo ver la información original del perfil
    And debo ver un mensaje "Cambios descartados"

  Scenario: Visualización del historial de cambios del perfil
    Given estoy en la sección de "Gestión de Perfil"
    When hago clic en "Ver Historial de Cambios"
    Then debo ver una lista de todas las modificaciones realizadas
    And cada registro debe mostrar: fecha, campo modificado, valor anterior, valor nuevo
    And los registros deben estar ordenados por fecha descendente