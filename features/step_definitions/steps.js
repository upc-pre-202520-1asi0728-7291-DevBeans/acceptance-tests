const { Given, When, Then, Before } = require('@cucumber/cucumber');

// ==================== PASOS GENÉRICOS GLOBALES ====================

Before(function() {
  this.users = {};
  this.lotes = {};
  this.cooperativas = {};
  this.reportes = {};
});

Given('el sistema BeanDetect AI está disponible', function() {
  this.sistemaActivo = true;
});

Given('la página de registro de productor está accesible', function() {
  this.paginaActual = 'registro-productor';
});

Given('la página de registro de cooperativa está accesible', function() {
  this.paginaActual = 'registro-cooperativa';
});

Given('la página de inicio de sesión está accesible', function() {
  this.paginaActual = 'login';
});

// ==================== US01: Registro de Productor ====================

Given('soy un productor de café pequeño o mediano', function() {
  this.usuario = { tipo: 'PRODUCTOR' };
});

Given('he completado el formulario de registro con información básica de mi finca \\(ubicación, hectáreas)', function() {
  this.usuario = {
    tipo: 'PRODUCTOR',
    nombre: 'Test Productor',
    email: 'test@productor.com',
    password: 'SecurePass123!',
    ubicacion: 'Cusco, Perú',
    hectareas: 5.0,
    variedad: 'TYPICA'
  };
  this.formularioCompleto = true;
});

When('envío mi solicitud de registro a BeanDetect AI', function() {
  this.registroEnviado = true;
  this.users[this.usuario.email] = this.usuario;
});

Then('debo recibir una confirmación de registro y obtener credenciales de acceso para la tecnología de clasificación', function() {
  if (!this.registroEnviado) throw new Error('Registro no enviado');
  this.credencialesGeneradas = true;
});

Given('estoy en la página de registro de productor', function() {
  this.paginaActual = 'registro-productor';
});

Given('ingreso mi nombre {string}', function(nombre) {
  this.usuario = this.usuario || {};
  this.usuario.nombre = nombre;
});

Given('ingreso mi email {string}', function(email) {
  this.usuario = this.usuario || {};
  this.usuario.email = email;
});

Given('ingreso mi contraseña {string}', function(password) {
  this.usuario = this.usuario || {};
  this.usuario.password = password;
});

Given('selecciono mi ubicación {string}', function(ubicacion) {
  this.usuario = this.usuario || {};
  this.usuario.ubicacion = ubicacion;
});

Given('ingreso el tamaño de mi finca {string} hectáreas', function(hectareas) {
  this.usuario = this.usuario || {};
  this.usuario.hectareas = parseFloat(hectareas);
});

Given('selecciono la variedad de café {string}', function(variedad) {
  this.usuario = this.usuario || {};
  this.usuario.variedad = variedad;
});

When('envío el formulario de registro', function() {
  this.registroProcessado = true;
  if (this.usuario && this.usuario.email) {
    this.users[this.usuario.email] = this.usuario;
  }
});

Then('debo recibir un mensaje de confirmación {string}', function(mensaje) {
  if (!this.registroProcessado && !this.errorRegistro) {
    throw new Error('Registro no procesado');
  }
  this.mensajeConfirmacion = mensaje;
});

Then('debo recibir un correo de bienvenida a {string}', function(email) {
  this.correoEnviado = { destinatario: email, tipo: 'bienvenida' };
});

Then('mi perfil debe estar creado con el rol {string}', function(rol) {
  if (this.usuario && this.usuario.tipo !== rol) {
    throw new Error(`Rol incorrecto: esperado ${rol}, obtenido ${this.usuario.tipo}`);
  }
});

Given('dejo el campo {string} sin completar', function(campo) {
  this.campoVacio = campo;
  if (this.usuario) {
    delete this.usuario[campo];
  }
});

When('intento enviar el formulario de registro', function() {
  if (this.campoVacio || this.emailInvalido) {
    this.errorRegistro = true;
  } else {
    this.registroProcessado = true;
  }
});

Then('debo ver un mensaje de error {string}', function(mensaje) {
  if (!this.errorRegistro && !this.emailDuplicado && !this.rucDuplicado) {
    throw new Error('Se esperaba un error pero no ocurrió');
  }
  this.mensajeError = mensaje;
});

Then('el registro no debe procesarse', function() {
  if (this.registroProcessado && (this.campoVacio || this.emailInvalido)) {
    throw new Error('El registro no debería haberse procesado');
  }
});

Given('completo todos los campos correctamente', function() {
  this.usuario = {
    tipo: 'PRODUCTOR',
    nombre: 'Test User',
    email: 'test@example.com',
    password: 'SecurePass123!',
    ubicacion: 'Cusco, Perú',
    hectareas: 5.0,
    variedad: 'TYPICA'
  };
});

Given('ingreso un email con formato inválido {string}', function(emailInvalido) {
  this.usuario = this.usuario || {};
  this.usuario.email = emailInvalido;
  this.emailInvalido = true;
});

Given('existe un productor registrado con email {string}', function(email) {
  this.users[email] = { 
    email: email, 
    tipo: 'PRODUCTOR',
    nombre: 'Usuario Existente',
    password: 'Pass123!'
  };
});

When('intento registrarme con el mismo email {string}', function(email) {
  this.emailDuplicado = true;
  this.emailIntento = email;
  this.errorRegistro = true;
});

Then('debo tener la opción de recuperar mi contraseña', function() {
  this.opcionRecuperacion = true;
});

// ==================== US02: Registro de Cooperativa ====================

Given('soy el administrador de una cooperativa cafetalera', function() {
  this.usuario = { tipo: 'COOPERATIVA' };
});

Given('tengo la información legal y operativa de la organización', function() {
  this.informacionLegal = true;
});

When('registro mi organización en BeanDetect AI', function() {
  this.organizacionRegistrada = true;
  if (this.usuario && this.usuario.ruc) {
    this.cooperativas[this.usuario.ruc] = this.usuario;
  }
});

Then('el sistema debe crear un perfil de cooperativa que me permita gestionar la clasificación de múltiples productores asociados', function() {
  if (!this.organizacionRegistrada) {
    throw new Error('Organización no registrada');
  }
  this.perfilCooperativa = true;
});

Given('ingreso el nombre de la cooperativa {string}', function(nombre) {
  this.usuario = this.usuario || { tipo: 'COOPERATIVA' };
  this.usuario.nombre = nombre;
});

Given('ingreso el email institucional {string}', function(email) {
  this.usuario = this.usuario || {};
  this.usuario.email = email;
});

Given('ingreso el número de RUC {string}', function(ruc) {
  this.usuario = this.usuario || {};
  this.usuario.ruc = ruc;
});

Given('ingreso la dirección legal {string}', function(direccion) {
  this.usuario = this.usuario || {};
  this.usuario.direccion = direccion;
});

Given('selecciono la región {string}', function(region) {
  this.usuario = this.usuario || {};
  this.usuario.region = region;
});

Given('ingreso el número de productores asociados {string}', function(num) {
  this.usuario = this.usuario || {};
  this.usuario.numProductores = parseInt(num);
});

Given('ingreso el nombre del representante legal {string}', function(representante) {
  this.usuario = this.usuario || {};
  this.usuario.representante = representante;
});

When('envío el formulario de registro de cooperativa', function() {
  this.registroProcessado = true;
  if (this.usuario && this.usuario.ruc) {
    this.cooperativas[this.usuario.ruc] = this.usuario;
  }
});

Then('debo tener acceso al panel de gestión de productores asociados', function() {
  this.accesoPanel = true;
});

Given('ingreso un RUC con formato inválido {string}', function(rucInvalido) {
  this.usuario = this.usuario || {};
  this.usuario.ruc = rucInvalido;
  this.rucInvalido = true;
});

Given('existe una cooperativa registrada con RUC {string}', function(ruc) {
  this.cooperativas[ruc] = { 
    ruc: ruc, 
    tipo: 'COOPERATIVA',
    nombre: 'Cooperativa Existente'
  };
});

When('intento registrarme con el mismo RUC {string}', function(ruc) {
  this.rucDuplicado = true;
  this.rucIntento = ruc;
  this.errorRegistro = true;
});

Then('debo tener información de contacto para soporte', function() {
  this.infoSoporte = true;
});

Given('he registrado exitosamente mi cooperativa {string}', function(nombre) {
  this.cooperativaActual = nombre;
  this.registroExitoso = true;
});

When('accedo a mi panel de administración', function() {
  this.enPanelAdmin = true;
});

Then('debo poder ver la opción {string}', function(opcion) {
  this.opcionesDisponibles = this.opcionesDisponibles || [];
  this.opcionesDisponibles.push(opcion);
});

// ==================== US03: Autenticación ====================

Given('soy un usuario registrado \\(productor o cooperativa)', function() {
  this.usuarioRegistrado = true;
});

Given('proporciono mi nombre de usuario y contraseña correctos', function() {
  this.credencialesCorrectas = true;
});

When('intento iniciar sesión en BeanDetect AI', function() {
  this.intentoSesion = true;
  if (this.credencialesCorrectas) {
    this.sesionActiva = true;
  }
});

Then('el sistema debe permitir mi acceso de forma segura y dirigir a la interfaz según mi perfil de usuario', function() {
  if (!this.sesionActiva) {
    throw new Error('Acceso no permitido');
  }
  this.interfazCargada = true;
});

Given('existe un usuario registrado con email {string} y rol {string}', function(email, rol) {
  this.users[email] = { 
    email: email, 
    rol: rol,
    tipo: rol,
    password: 'SecurePass123!',
    nombre: 'Usuario Test'
  };
});

Given('estoy en la página de inicio de sesión', function() {
  this.paginaActual = 'login';
});

When('ingreso el email {string}', function(email) {
  this.emailIntento = email;
});

When('ingreso la contraseña {string}', function(password) {
  this.passwordIntento = password;
});

When('hago clic en el botón {string}', function(boton) {
  if (boton === 'Iniciar Sesión') {
    this.sesionIntento = true;
    if (this.emailIntento in this.users && this.passwordIntento === 'SecurePass123!') {
      this.autenticado = true;
      this.usuarioActual = this.users[this.emailIntento];
    } else {
      this.autenticado = false;
    }
  } else if (boton === 'Cerrar Sesión') {
    this.sesionActiva = false;
    this.autenticado = false;
  }
});

Then('debo ser autenticado exitosamente', function() {
  if (!this.autenticado) {
    throw new Error('Autenticación fallida');
  }
});

Then('debo ser redirigido a {string}', function(pagina) {
  this.paginaDestino = pagina;
});

Then('debo ver el mensaje de bienvenida {string}', function(mensaje) {
  this.mensajeBienvenida = mensaje;
});

When('ingreso una contraseña incorrecta {string}', function(password) {
  this.passwordIntento = password;
  this.passwordIncorrecta = true;
});

Then('no debo ser autenticado', function() {
  if (this.autenticado) {
    throw new Error('No debería estar autenticado');
  }
});

Then('debo permanecer en la página de inicio de sesión', function() {
  if (this.autenticado) {
    throw new Error('No debería haber sido redirigido');
  }
  this.paginaActual = 'login';
});

Given('no existe ningún usuario registrado con email {string}', function(email) {
  delete this.users[email];
});

When('ingreso cualquier contraseña {string}', function(password) {
  this.passwordIntento = password;
});

When('ingreso una contraseña incorrecta {int} veces consecutivas', function(veces) {
  this.intentosFallidos = veces;
  if (veces >= 5) {
    this.cuentaBloqueada = true;
  }
});

Then('la cuenta debe quedar bloqueada por {int} minutos', function(minutos) {
  if (!this.cuentaBloqueada) {
    throw new Error('Cuenta no bloqueada');
  }
  this.tiempoBloqueo = minutos;
});

Then('debo recibir un correo de notificación de bloqueo', function() {
  this.correoBloqueo = true;
});

Given('he iniciado sesión exitosamente como {string}', function(email) {
  this.usuarioActual = this.users[email] || { email: email };
  this.sesionActiva = true;
  this.autenticado = true;
});

Given('estoy en mi dashboard', function() {
  this.paginaActual = 'dashboard';
});

Then('mi sesión debe ser cerrada correctamente', function() {
  if (this.sesionActiva) {
    throw new Error('Sesión aún activa');
  }
});

Then('no debo poder acceder a páginas protegidas sin autenticarme nuevamente', function() {
  this.accesoRestringido = !this.sesionActiva;
});

When('marco la opción {string}', function(opcion) {
  if (opcion === 'Recordarme') {
    this.recordarme = true;
  }
});

Then('mi sesión debe persistir por {int} días', function(dias) {
  if (this.recordarme) {
    this.persistenciaSesion = dias;
  }
});

Then('no debo necesitar ingresar credenciales nuevamente durante ese período', function() {
  this.sesionPersistente = this.recordarme;
});

// ==================== US04: Gestión de Perfil ====================

Given('he iniciado sesión como productor', function() {
  this.usuarioActual = { 
    tipo: 'PRODUCTOR',
    email: 'productor@test.com',
    nombre: 'Productor Test'
  };
  this.sesionActiva = true;
});

Given('necesito actualizar la información de mi finca \\(e.g., nuevas hectáreas o variedades de café)', function() {
  this.actualizacionPendiente = true;
  this.perfil = {
    hectareas: 5.0,
    ubicacion: 'Cusco, Perú',
    variedad: 'TYPICA'
  };
});

When('edito y guardo los cambios en la sección de gestión de perfil', function() {
  this.perfil.hectareas = 6.5;
  this.perfilActualizado = true;
});

Then('la información de mi finca \\(ubicación, hectáreas, variedades) debe quedar actualizada en el sistema para personalizar mi experiencia', function() {
  if (!this.perfilActualizado) {
    throw new Error('Perfil no actualizado');
  }
});

Given('estoy en la sección de {string}', function(seccion) {
  this.seccionActual = seccion;
});

Given('mi perfil actual tiene la información inicial', function() {
  this.perfil = {
    hectareas: 5.0,
    ubicacion: 'Cusco, Perú',
    variedad: 'TYPICA',
    telefono: '+51 900 000 000',
    altitude: 1500,
    metodo_cultivo: 'Tradicional'
  };
});

When('actualizo el campo {string} con el nuevo valor {string}', function(campo, valor) {
  this.perfil[campo] = valor;
  this.campoActualizado = campo;
  this.valorNuevo = valor;
});

When('hago clic en {string}', function(boton) {
  if (boton === 'Guardar Cambios') {
    this.cambiosGuardados = true;
  } else if (boton === 'Cancelar') {
    this.cancelado = true;
    this.cambiosGuardados = false;
  } else if (boton === 'Ver Historial de Cambios') {
    this.historialVisible = true;
  } else if (boton === 'Registrar Nuevo Lote') {
    this.formularioLote = true;
  } else if (boton === 'Registrar Lote') {
    this.registrarLote();
  } else if (boton === 'Editar Lote') {
    this.modoEdicion = true;
  } else if (boton === 'Eliminar Lote') {
    this.dialogoConfirmacion = true;
  } else if (boton === 'Confirmar Eliminación') {
    this.formularioRazon = true;
  } else if (boton === 'Exportar a CSV') {
    this.exportarCSV = true;
  }
});

Then('el campo {string} debe mostrar el nuevo valor {string}', function(campo, valor) {
  if (this.perfil[campo] !== valor) {
    throw new Error(`Campo ${campo} no actualizado correctamente`);
  }
});

Then('debo recibir un correo de confirmación de actualización', function() {
  this.correoConfirmacion = true;
});

Given('estoy en la sección de {string}$', function(seccion) {
  this.seccionActual = seccion;
});

When('actualizo el teléfono a {string}', function(telefono) {
  this.perfil = this.perfil || {};
  this.perfil.telefono = telefono;
});

When('actualizo el email secundario a {string}', function(emailSecundario) {
  this.perfil = this.perfil || {};
  this.perfil.emailSecundario = emailSecundario;
});

Then('la información de contacto debe actualizarse correctamente', function() {
  if (!this.cambiosGuardados) {
    throw new Error('Información no actualizada');
  }
});

Then('debo recibir una confirmación en {string}', function(email) {
  this.correoEnviado = { destinatario: email, tipo: 'confirmacion' };
});

When('intento actualizar {string} con un valor inválido {string}', function(campo, valor) {
  this.perfil = this.perfil || {};
  this.perfil[campo] = valor;
  this.valorInvalido = true;
  this.errorValidacion = true;
});

Then('los cambios no deben guardarse', function() {
  if (this.valorInvalido || this.cancelado) {
    this.cambiosGuardados = false;
  }
});

Given('actualmente cultivo {string}', function(variedades) {
  this.variedadesActuales = variedades.split(', ');
});

When('agrego la variedad {string} a mi lista', function(variedad) {
  this.variedadesActuales = this.variedadesActuales || [];
  if (!this.variedadesActuales.includes(variedad)) {
    this.variedadesActuales.push(variedad);
  }
});

When('elimino la variedad {string} de mi lista', function(variedad) {
  this.variedadesActuales = this.variedadesActuales.filter(v => v !== variedad);
});

Then('mis variedades deben actualizarse a {string}', function(variedades) {
  const variedadesEsperadas = variedades.split(', ').sort();
  const variedadesActuales = this.variedadesActuales.sort();
  if (JSON.stringify(variedadesActuales) !== JSON.stringify(variedadesEsperadas)) {
    throw new Error('Variedades no coinciden');
  }
});

Then('debo ver un mensaje {string}', function(mensaje) {
  this.mensajeMostrado = mensaje;
});

When('subo una nueva foto de perfil en formato {word} de {int}MB', function(formato, tamaño) {
  this.fotoSubida = { formato: formato, tamaño: tamaño };
  if (['JPG', 'PNG', 'JPEG'].includes(formato.toUpperCase()) && tamaño <= 5) {
    this.fotoValida = true;
  }
});

Then('mi foto de perfil debe actualizarse correctamente', function() {
  if (!this.fotoValida) {
    throw new Error('Foto no válida');
  }
  this.fotoPerfil = this.fotoSubida;
});

Then('debo ver la nueva foto en el header del sistema', function() {
  this.fotoEnHeader = true;
});

When('intento subir una foto con formato {string} y tamaño {string}', function(formato, tamaño) {
  const tamaañoNum = parseFloat(tamaño.replace('MB', ''));
  this.intentoSubidaFoto = { formato: formato, tamaño: tamaañoNum };
  
  if (!['JPG', 'PNG', 'JPEG'].includes(formato.toUpperCase())) {
    this.errorFormato = true;
  }
  if (tamaañoNum > 5) {
    this.errorTamaño = true;
  }
});

Then('debo ver un mensaje {string}$', function(mensaje) {
  this.mensajeMostrado = mensaje;
});

Then('debo ver la información original del perfil', function() {
  this.perfilOriginalVisible = true;
});

Then('debo ver una lista de todas las modificaciones realizadas', function() {
  this.historialModificaciones = true;
});

Then('cada registro debe mostrar: fecha, campo modificado, valor anterior, valor nuevo', function() {
  this.formatoHistorial = ['fecha', 'campo', 'valorAnterior', 'valorNuevo'];
});

Then('los registros deben estar ordenados por fecha descendente', function() {
  this.ordenHistorial = 'descendente';
});

// ==================== US06: Creación de Lotes ====================

Given('he iniciado sesión en el sistema', function() {
  this.sesionActiva = true;
  this.usuarioActual = this.usuarioActual || { tipo: 'PRODUCTOR' };
});

Given('soy un usuario \\(productor o cooperativa) y he iniciado sesión', function() {
  this.sesionActiva = true;
  this.usuarioActual = { tipo: 'PRODUCTOR' };
});

When('registro un nuevo lote de café completando la información básica requerida \\(fecha de cosecha, variedad, origen)', function() {
  this.lote = {
    fechaCosecha: '2024-05-15',
    variedad: 'TYPICA',
    cantidad: 500,
    metodo: 'WASHED',
    ubicacion: { latitud: -12.0464, longitud: -77.0428 },
    altitud: 1500,
    codigo: this.generarCodigoLote()
  };
  this.loteRegistrado = true;
  this.lotes[this.lote.codigo] = this.lote;
});

Then('el lote debe ser creado en mi inventario, permitiéndome organizar mi producción de forma eficiente', function() {
  if (!this.loteRegistrado) {
    throw new Error('Lote no registrado');
  }
});

When('ingreso la fecha de cosecha {string}', function(fecha) {
  this.lote = this.lote || {};
  this.lote.fechaCosecha = fecha;
});

When('selecciono la variedad de café {string}', function(variedad) {
  this.lote = this.lote || {};
  this.lote.variedad = variedad;
});

When('ingreso la cantidad en kilogramos {string}', function(cantidad) {
  this.lote = this.lote || {};
  this.lote.cantidad = parseFloat(cantidad);
});

When('selecciono el método de procesamiento {string}', function(metodo) {
  this.lote = this.lote || {};
  this.lote.metodo = metodo;
});

When('ingreso la ubicación con latitud {string} y longitud {string}', function(lat, lon) {
  this.lote = this.lote || {};
  this.lote.ubicacion = { 
    latitud: parseFloat(lat), 
    longitud: parseFloat(lon) 
  };
});

When('ingreso la altitud {string} metros', function(altitud) {
  this.lote = this.lote || {};
  this.lote.altitud = parseFloat(altitud);
});

Then('se debe generar un código único de lote {string}', function(codigo) {
  this.codigoEsperado = codigo;
});

Then('el lote debe aparecer en mi lista de lotes', function() {
  if (!this.loteRegistrado) {
    throw new Error('Lote no encontrado en la lista');
  }
});

Given('estoy en el formulario de {string}', function(formulario) {
  this.formularioActual = formulario;
});

When('ingreso una latitud inválida {string}', function(latitud) {
  this.lote = this.lote || {};
  this.lote.ubicacion = this.lote.ubicacion || {};
  this.lote.ubicacion.latitud = latitud;
  this.latitudInvalida = true;
});

When('ingreso una longitud inválida {string}', function(longitud) {
  this.lote = this.lote || {};
  this.lote.ubicacion = this.lote.ubicacion || {};
  this.lote.ubicacion.longitud = longitud;
  this.longitudInvalida = true;
});

When('ingreso una fecha de cosecha futura {string}', function(fecha) {
  this.lote = this.lote || {};
  this.lote.fechaCosecha = fecha;
  this.fechaFutura = true;
});

When('completo todos los demás campos correctamente', function() {
  this.lote = this.lote || {};
  this.lote.variedad = 'TYPICA';
  this.lote.cantidad = 500;
  this.lote.metodo = 'WASHED';
  this.lote.ubicacion = { latitud: -12.0464, longitud: -77.0428 };
  this.lote.altitud = 1500;
});

When('completo todos los campos obligatorios', function() {
  this.lote = this.lote || {};
  this.lote.fechaCosecha = '2024-05-15';
  this.lote.variedad = 'TYPICA';
  this.lote.cantidad = 500;
  this.lote.metodo = 'WASHED';
  this.lote.ubicacion = { latitud: -12.0464, longitud: -77.0428 };
});

When('agrego información opcional: tipo de suelo {string}', function(suelo) {
  this.lote = this.lote || {};
  this.lote.tipoSuelo = suelo;
});

When('agrego información opcional: zona climática {string}', function(zona) {
  this.lote = this.lote || {};
  this.lote.zonaClimatica = zona;
});

When('agrego información opcional: sección de finca {string}', function(seccion) {
  this.lote = this.lote || {};
  this.lote.seccionFinca = seccion;
});

Then('el lote debe registrarse con toda la información completa', function() {
  if (!this.loteRegistrado) {
    throw new Error('Lote no registrado');
  }
});

Then('debo poder ver la información adicional en los detalles del lote', function() {
  this.informacionAdicionalVisible = true;
});

Given('he registrado {int} lotes en el año 2024', function(cantidad) {
  for (let i = 1; i <= cantidad; i++) {
    const codigo = `LOT-2024-${String(i).padStart(4, '0')}`;
    this.lotes[codigo] = { codigo: codigo };
  }
});

When('registro un nuevo lote', function() {
  this.registrarLote();
});

Then('el sistema debe generar automáticamente el código {string}', function(codigo) {
  if (this.lote && this.lote.codigo !== codigo) {
    throw new Error(`Código esperado: ${codigo}, obtenido: ${this.lote.codigo}`);
  }
});

Then('el código debe ser único en todo el sistema', function() {
  const codigos = Object.keys(this.lotes);
  const codigosUnicos = new Set(codigos);
  if (codigos.length !== codigosUnicos.size) {
    throw new Error('Códigos duplicados encontrados');
  }
});

Then('el código debe seguir el formato {string}', function(formato) {
  const regex = /^LOT-\d{4}-\d{4}$/;
  if (this.lote && !regex.test(this.lote.codigo)) {
    throw new Error(`Código no sigue el formato esperado: ${formato}`);
  }
});

Then('debo ver una confirmación visual con el código del lote generado', function() {
  this.confirmacionVisual = true;
  this.codigoVisible = this.lote.codigo;
});

Then('debo tener la opción de {string}', function(opcion) {
  this.opcionesDisponibles = this.opcionesDisponibles || [];
  this.opcionesDisponibles.push(opcion);
});

// ==================== US07: Edición de Lotes ====================

Given('tengo al menos un lote registrado', function() {
  this.lotes = this.lotes || {};
  if (Object.keys(this.lotes).length === 0) {
    this.lotes['LOT-2024-0001'] = {
      codigo: 'LOT-2024-0001',
      variedad: 'TYPICA',
      cantidad: 500,
      estado: 'REGISTERED'
    };
  }
});

Given('tengo un lote de café registrado en el sistema', function() {
  this.lote = {
    codigo: 'LOT-2024-0001',
    variedad: 'TYPICA',
    cantidad: 500,
    estado: 'REGISTERED'
  };
  this.lotes[this.lote.codigo] = this.lote;
});

Given('he detectado un error o un cambio en su información \\(e.g., corregir la variedad)', function() {
  this.errorDetectado = true;
  this.campoACorregir = 'variedad';
});

When('accedo a la opción de edición y guardo los nuevos datos del lote', function() {
  if (this.lote) {
    this.lote.variedad = 'CATURRA';
    this.edicionGuardada = true;
  }
});

Then('la información del lote debe ser actualizada correctamente en la base de datos', function() {
  if (!this.edicionGuardada) {
    throw new Error('Información no actualizada');
  }
});

Given('tengo un lote registrado con código {string}', function(codigo) {
  this.loteActual = codigo;
  this.lote = this.lotes[codigo] || {
    codigo: codigo,
    cantidad: 500,
    variedad: 'TYPICA',
    metodo: 'WASHED',
    altitud: 1500,
    estado: 'REGISTERED'
  };
  this.lotes[codigo] = this.lote;
});

Given('estoy en la vista de detalles del lote', function() {
  this.vistaDetalles = true;
});

Then('el código del lote no debe cambiar', function() {
  const codigoOriginal = this.loteActual;
  if (this.lote.codigo !== codigoOriginal) {
    throw new Error('El código del lote cambió');
  }
});

Given('tengo un lote registrado con estado {string}', function(estado) {
  this.lote = this.lote || { codigo: 'LOT-2024-0001' };
  this.lote.estado = estado;
  this.lotes[this.lote.codigo] = this.lote;
});

When('intento editar la información del lote', function() {
  this.intentoEdicion = true;
  if (this.lote.estado === 'CLASSIFIED' || this.lote.estado === 'CERTIFIED' || this.lote.estado === 'SHIPPED') {
    this.edicionBloqueada = true;
  }
});

Then('{string}', function(resultado) {
  this.resultadoAccion = resultado;
});

Given('tengo un lote con código {string} en estado {string}', function(codigo, estado) {
  this.lote = {
    codigo: codigo,
    estado: estado,
    variedad: 'TYPICA',
    cantidad: 500
  };
  this.lotes[codigo] = this.lote;
  this.loteActual = codigo;
});

When('intento acceder a la opción de edición', function() {
  this.intentoAccesoEdicion = true;
  if (this.lote.estado === 'CLASSIFIED') {
    this.edicionBloqueada = true;
  }
});

Then('debo ver un mensaje informativo {string}', function(mensaje) {
  if (this.edicionBloqueada) {
    this.mensajeInformativo = mensaje;
  }
});

Then('el botón {string} debe estar deshabilitado', function(boton) {
  if (boton === 'Editar Lote' && this.edicionBloqueada) {
    this.botonDeshabilitado = true;
  }
});

Then('debo ver la opción {string} para casos excepcionales', function(opcion) {
  this.opcionEspecial = opcion;
});

Given('estoy en modo de edición del lote', function() {
  this.modoEdicion = true;
});

When('intento actualizar el campo {string} con {string}', function(campo, valor) {
  this.lote = this.lote || {};
  const valorNum = parseFloat(valor);
  
  if (campo === 'cantidad' || campo === 'altitud') {
    if (isNaN(valorNum) || valorNum <= 0) {
      this.valorInvalido = true;
      this.errorValidacion = true;
    } else if (campo === 'altitud' && valorNum > 5000) {
      this.valorInvalido = true;
      this.errorValidacion = true;
    } else {
      this.lote[campo] = valorNum;
    }
  } else {
    this.lote[campo] = valor;
  }
});

Given('estoy editando el método de procesamiento de {string} a {string}', function(de, a) {
  this.lote = this.lote || {};
  this.lote.metodo = de;
  this.metodoOriginal = de;
  this.metodoNuevo = a;
  this.cambioImportante = true;
});

Then('debo ver un diálogo de confirmación {string}', function(mensaje) {
  if (this.cambioImportante) {
    this.dialogoConfirmacion = mensaje;
  }
});

When('confirmo los cambios', function() {
  this.cambioConfirmado = true;
});

Then('los cambios deben guardarse correctamente', function() {
  if (this.cambioConfirmado && this.lote) {
    this.lote.metodo = this.metodoNuevo;
    this.cambiosGuardados = true;
  }
});

Given('he modificado varios campos', function() {
  this.camposModificados = true;
});

Then('debo volver a la vista de detalles del lote con la información original', function() {
  if (this.cancelado) {
    this.vistaDetalles = true;
    this.informacionOriginal = true;
  }
});

Then('debo ver una lista de todas las modificaciones realizadas al lote', function() {
  this.historialModificaciones = true;
});

Then('cada modificación debe mostrar: fecha, usuario, campo modificado, valor anterior, valor nuevo', function() {
  this.formatoHistorialLote = ['fecha', 'usuario', 'campo', 'valorAnterior', 'valorNuevo'];
});

Then('las modificaciones deben estar ordenadas por fecha descendente', function() {
  this.ordenHistorial = 'descendente';
});

Given('soy una cooperativa', function() {
  this.usuarioActual = { tipo: 'COOPERATIVA', nombre: 'Cooperativa Test' };
});

Given('tengo un lote registrado por un productor asociado', function() {
  this.loteProductorAsociado = {
    codigo: 'LOT-2024-0001',
    productor: 'Productor Test',
    cooperativa: this.usuarioActual.nombre
  };
  this.lotes[this.loteProductorAsociado.codigo] = this.loteProductorAsociado;
});

When('el productor edita información del lote', function() {
  this.loteProductorAsociado.cantidad = 600;
  this.notificacionPendiente = true;
});

Then('debo recibir una notificación de la modificación realizada', function() {
  if (this.notificacionPendiente) {
    this.notificacionRecibida = true;
  }
});

Then('la notificación debe incluir: código del lote, fecha, campos modificados', function() {
  this.contenidoNotificacion = ['codigoLote', 'fecha', 'camposModificados'];
});

Given('estoy editando la ubicación del lote', function() {
  this.editandoUbicacion = true;
});

When('intento actualizar latitud a {string} y longitud a {string}', function(lat, lon) {
  const latNum = parseFloat(lat);
  const lonNum = parseFloat(lon);
  
  this.lote = this.lote || {};
  this.lote.ubicacion = { latitud: latNum, longitud: lonNum };
  
  if (latNum < -90 || latNum > 90) {
    this.errorLatitud = true;
    this.errorValidacion = true;
  }
  if (lonNum < -180 || lonNum > 180) {
    this.errorLongitud = true;
    this.errorValidacion = true;
  }
});

Then('debo ver el resultado {string}', function(resultado) {
  this.resultadoMostrado = resultado;
});

// ==================== US08: Visualización de Lotes ====================

Given('soy un productor y he iniciado sesión', function() {
  this.usuarioActual = { tipo: 'PRODUCTOR', id: 1, nombre: 'Productor Test' };
  this.sesionActiva = true;
});

Given('tengo varios lotes registrados a mi nombre', function() {
  this.lotes = {
    'LOT-2024-0001': { codigo: 'LOT-2024-0001', productor: this.usuarioActual.id },
    'LOT-2024-0002': { codigo: 'LOT-2024-0002', productor: this.usuarioActual.id },
    'LOT-2024-0003': { codigo: 'LOT-2024-0003', productor: this.usuarioActual.id }
  };
});

When('accedo a la sección para ver mis lotes', function() {
  this.seccionMisLotes = true;
});

Then('el sistema debe mostrarme todos mis lotes en una vista simple y fácil de entender, sin complejidad técnica', function() {
  if (!this.seccionMisLotes) {
    throw new Error('No se accedió a la sección');
  }
  this.vistaSimple = true;
});

Given('soy un productor con ID {string}', function(id) {
  this.usuarioActual = { tipo: 'PRODUCTOR', id: id };
});

Given('tengo {string} lotes registrados', function(cantidad) {
  const num = parseInt(cantidad);
  this.lotes = {};
  for (let i = 1; i <= num; i++) {
    const codigo = `LOT-2024-${String(i).padStart(4, '0')}`;
    this.lotes[codigo] = {
      codigo: codigo,
      fechaCosecha: '2024-05-15',
      variedad: 'TYPICA',
      cantidad: 500,
      estado: 'REGISTERED'
    };
  }
});

When('accedo a {string}', function(seccion) {
  this.seccionActual = seccion;
});

Then('debo ver exactamente {string} lotes en la lista', function(cantidad) {
  const cantidadEsperada = parseInt(cantidad);
  const cantidadActual = Object.keys(this.lotes).length;
  if (cantidadActual !== cantidadEsperada) {
    throw new Error(`Esperados ${cantidadEsperada} lotes, encontrados ${cantidadActual}`);
  }
});

Then('cada lote debe mostrar: código, fecha de cosecha, variedad, cantidad, estado', function() {
  this.camposMostrados = ['codigo', 'fechaCosecha', 'variedad', 'cantidad', 'estado'];
});

Given('tengo múltiples lotes en diferentes estados', function() {
  this.lotes = {
    'LOT-2024-0001': { codigo: 'LOT-2024-0001', estado: 'REGISTERED' },
    'LOT-2024-0002': { codigo: 'LOT-2024-0002', estado: 'REGISTERED' },
    'LOT-2024-0003': { codigo: 'LOT-2024-0003', estado: 'REGISTERED' },
    'LOT-2024-0004': { codigo: 'LOT-2024-0004', estado: 'PROCESSING' },
    'LOT-2024-0005': { codigo: 'LOT-2024-0005', estado: 'PROCESSING' },
    'LOT-2024-0006': { codigo: 'LOT-2024-0006', estado: 'CLASSIFIED' },
    'LOT-2024-0007': { codigo: 'LOT-2024-0007', estado: 'CLASSIFIED' },
    'LOT-2024-0008': { codigo: 'LOT-2024-0008', estado: 'CLASSIFIED' },
    'LOT-2024-0009': { codigo: 'LOT-2024-0009', estado: 'CLASSIFIED' },
    'LOT-2024-0010': { codigo: 'LOT-2024-0010', estado: 'CERTIFIED' }
  };
});

When('filtro mis lotes por estado {string}', function(estado) {
  this.filtroEstado = estado;
  this.lotesFiltrados = Object.values(this.lotes).filter(lote => lote.estado === estado);
});

Then('debo ver solo los lotes con estado {string}', function(estado) {
  this.lotesFiltrados.forEach(lote => {
    if (lote.estado !== estado) {
      throw new Error(`Lote con estado incorrecto: ${lote.estado}`);
    }
  });
});

Then('el contador debe mostrar {string} lotes', function(cantidad) {
  const cantidadEsperada = parseInt(cantidad);
  if (this.lotesFiltrados.length !== cantidadEsperada) {
    throw new Error(`Contador incorrecto: esperado ${cantidadEsperada}, obtenido ${this.lotesFiltrados.length}`);
  }
});

Given('tengo lotes de diferentes años de cosecha', function() {
  this.lotes = {
    'LOT-2023-0001': { codigo: 'LOT-2023-0001', fechaCosecha: '2023-05-15' },
    'LOT-2024-0001': { codigo: 'LOT-2024-0001', fechaCosecha: '2024-05-15' },
    'LOT-2024-0002': { codigo: 'LOT-2024-0002', fechaCosecha: '2024-06-20' },
    'LOT-2025-0001': { codigo: 'LOT-2025-0001', fechaCosecha: '2025-01-10' }
  };
});

When('filtro mis lotes por año {string}', function(año) {
  this.filtroAño = año;
  this.lotesFiltrados = Object.values(this.lotes).filter(lote => 
    lote.fechaCosecha.startsWith(año)
  );
});

Then('debo ver solo los lotes cosechados en {string}', function(año) {
  this.lotesFiltrados.forEach(lote => {
    if (!lote.fechaCosecha.startsWith(año)) {
      throw new Error(`Lote con año incorrecto: ${lote.fechaCosecha}`);
    }
  });
});

Then('cada lote mostrado debe tener fecha de cosecha en el año {string}', function(año) {
  this.lotesFiltrados.forEach(lote => {
    const añoLote = lote.fechaCosecha.substring(0, 4);
    if (añoLote !== año) {
      throw new Error(`Año incorrecto: ${añoLote}`);
    }
  });
});

Given('tengo {int} lotes registrados', function(cantidad) {
  this.lotes = {};
  for (let i = 1; i <= cantidad; i++) {
    const codigo = `LOT-2024-${String(i).padStart(4, '0')}`;
    this.lotes[codigo] = {
      codigo: codigo,
      fechaCosecha: `2024-${String(5 + i).padStart(2, '0')}-15`
    };
  }
});

When('selecciono ordenar por {string}', function(criterio) {
  this.criterioOrdenamiento = criterio;
  if (criterio.includes('reciente')) {
    this.lotesOrdenados = Object.values(this.lotes).sort((a, b) => 
      b.fechaCosecha.localeCompare(a.fechaCosecha)
    );
  }
});

Then('los lotes deben mostrarse ordenados del más reciente al más antiguo', function() {
  for (let i = 0; i < this.lotesOrdenados.length - 1; i++) {
    if (this.lotesOrdenados[i].fechaCosecha < this.lotesOrdenados[i + 1].fechaCosecha) {
      throw new Error('Lotes no ordenados correctamente');
    }
  }
});

Then('el primer lote debe ser el de fecha más reciente', function() {
  const primerLote = this.lotesOrdenados[0];
  const fechaMasReciente = Math.max(...this.lotesOrdenados.map(l => new Date(l.fechaCosecha)));
  if (new Date(primerLote.fechaCosecha).getTime() !== fechaMasReciente) {
    throw new Error('Primer lote no es el más reciente');
  }
});

Given('tengo múltiples lotes registrados', function() {
  this.lotes = {
    'LOT-2024-0001': { codigo: 'LOT-2024-0001' },
    'LOT-2024-0002': { codigo: 'LOT-2024-0002' },
    'LOT-2024-0003': { codigo: 'LOT-2024-0003' },
    'LOT-2023-0001': { codigo: 'LOT-2023-0001' }
  };
});

When('ingreso {string} en el campo de búsqueda', function(busqueda) {
  this.terminoBusqueda = busqueda;
  this.resultadosBusqueda = Object.values(this.lotes).filter(lote =>
    lote.codigo.includes(busqueda)
  );
});

Then('debo ver los lotes que coincidan con {string}', function(busqueda) {
  this.resultadosBusqueda.forEach(lote => {
    if (!lote.codigo.includes(busqueda)) {
      throw new Error(`Lote ${lote.codigo} no coincide con búsqueda`);
    }
  });
});

Then('debo ver {string}', function(resultado) {
  this.resultadoMostrado = resultado;
});

Then('debo ver un resumen con:', function(dataTable) {
  this.resumenEstadistico = dataTable.rawTable;
});

Given('tengo el lote {string} registrado', function(codigo) {
  this.lote = {
    codigo: codigo,
    fechaCosecha: '15/05/2024',
    variedad: 'TYPICA',
    cantidad: 500,
    estado: 'CLASSIFIED',
    metodo: 'WASHED',
    ubicacion: 'Cusco, Perú'
  };
  this.lotes[codigo] = this.lote;
});

When('hago clic en {string} del lote {string}', function(accion, codigo) {
  if (accion === 'Ver Detalles') {
    this.detallesVisible = true;
    this.loteDetalle = this.lotes[codigo];
  }
});

Then('debo ver toda la información del lote incluyendo:', function(dataTable) {
  this.camposDetalle = dataTable.rawTable;
});

Given('la configuración de paginación es {int} lotes por página', function(porPagina) {
  this.lotesPorPagina = porPagina;
});

Then('debo ver los primeros {int} lotes', function(cantidad) {
  this.lotesPaginaActual = Object.values(this.lotes).slice(0, cantidad);
});

Then('debo ver controles de paginación {string}', function(controles) {
  this.controlesPaginacion = controles;
});

When('hago clic en {string}', function(elemento) {
  if (elemento.includes('Página')) {
    const numeroPagina = parseInt(elemento.match(/\d+/)[0]);
    this.paginaActual = numeroPagina;
    const inicio = (numeroPagina - 1) * this.lotesPorPagina;
    const fin = inicio + this.lotesPorPagina;
    this.lotesPaginaActual = Object.values(this.lotes).slice(inicio, fin);
  }
});

Then('debo ver los lotes {int} al {int}', function(inicio, fin) {
  if (this.lotesPaginaActual.length !== (fin - inicio + 1)) {
    throw new Error(`Cantidad incorrecta de lotes en página`);
  }
});

Then('debe descargarse un archivo CSV con todos mis lotes', function() {
  this.archivoCSV = true;
});

Then('el archivo debe contener las columnas: Código, Fecha, Variedad, Cantidad, Estado', function() {
  this.columnasCSV = ['Código', 'Fecha', 'Variedad', 'Cantidad', 'Estado'];
});

Given('accedo a {string} desde un dispositivo móvil', function(seccion) {
  this.dispositivoMovil = true;
  this.seccionActual = seccion;
});

Then('la lista de lotes debe adaptarse al tamaño de pantalla', function() {
  this.vistaResponsive = true;
});

Then('la información debe ser fácilmente legible', function() {
  this.legibilidad = true;
});

Then('los controles deben ser accesibles con el dedo', function() {
  this.controlesAccesibles = true;
});

// ==================== US10: Búsqueda Rápida ====================

Given('tengo un gran número de lotes registrados', function() {
  this.lotes = {};
  for (let i = 1; i <= 50; i++) {
    const codigo = `LOT-2024-${String(i).padStart(4, '0')}`;
    this.lotes[codigo] = {
      codigo: codigo,
      variedad: ['TYPICA', 'CATURRA', 'BOURBON'][i % 3],
      metodo: ['WASHED', 'NATURAL', 'HONEY'][i % 3],
      estado: ['REGISTERED', 'PROCESSING', 'CLASSIFIED'][i % 3]
    };
  }
});

When('utilizo la función de búsqueda ingresando criterios como fecha, productor \\(si soy cooperativa) o variedad', function() {
  this.busquedaRealizada = true;
  this.criteriosBusqueda = ['fecha', 'variedad'];
});

Then('el sistema debe filtrar y mostrarme rápidamente los lotes que coinciden con los criterios específicos', function() {
  if (!this.busquedaRealizada) {
    throw new Error('Búsqueda no realizada');
  }
  this.resultadosFiltrados = true;
});

When('busco lotes con fecha de cosecha entre {string} y {string}', function(fechaInicio, fechaFin) {
  this.rangoFechas = { inicio: fechaInicio, fin: fechaFin };
  this.lotesFiltrados = Object.values(this.lotes).filter(lote => {
    const fecha = lote.fechaCosecha || '2024-06-01';
    return fecha >= fechaInicio && fecha <= fechaFin;
  });
});

Then('todos los lotes deben tener fecha de cosecha dentro del rango especificado', function() {
  this.lotesFiltrados.forEach(lote => {
    const fecha = lote.fechaCosecha || '2024-06-01';
    if (fecha < this.rangoFechas.inicio || fecha > this.rangoFechas.fin) {
      throw new Error('Lote fuera del rango de fechas');
    }
  });
});

Given('tengo lotes de múltiples variedades', function() {
  this.lotes = {
    'LOT-2024-0001': { codigo: 'LOT-2024-0001', variedad: 'TYPICA' },
    'LOT-2024-0002': { codigo: 'LOT-2024-0002', variedad: 'TYPICA' },
    'LOT-2024-0003': { codigo: 'LOT-2024-0003', variedad: 'CATURRA' },
    'LOT-2024-0004': { codigo: 'LOT-2024-0004', variedad: 'BOURBON' },
    'LOT-2024-0005': { codigo: 'LOT-2024-0005', variedad: 'GEISHA' }
  };
});

When('busco lotes de variedad {string}', function(variedad) {
  this.filtroVariedad = variedad;
  this.lotesFiltrados = Object.values(this.lotes).filter(lote =>
    lote.variedad === variedad
  );
});

Then('debo ver solo lotes de la variedad {string}', function(variedad) {
  this.lotesFiltrados.forEach(lote => {
    if (lote.variedad !== variedad) {
      throw new Error(`Variedad incorrecta: ${lote.variedad}`);
    }
  });
});

Then('el resultado debe incluir {string} lotes', function(cantidad) {
  const cantidadEsperada = parseInt(cantidad);
  if (this.lotesFiltrados.length !== cantidadEsperada) {
    throw new Error(`Cantidad incorrecta: esperado ${cantidadEsperada}, obtenido ${this.lotesFiltrados.length}`);
  }
});

Given('tengo lotes con diferentes características', function() {
  this.lotes = {
    'LOT-2024-0001': { variedad: 'TYPICA', metodo: 'WASHED', estado: 'CLASSIFIED' },
    'LOT-2024-0002': { variedad: 'TYPICA', metodo: 'WASHED', estado: 'CLASSIFIED' },
    'LOT-2024-0003': { variedad: 'TYPICA', metodo: 'WASHED', estado: 'CLASSIFIED' },
    'LOT-2024-0004': { variedad: 'CATURRA', metodo: 'NATURAL', estado: 'REGISTERED' },
    'LOT-2024-0005': { variedad: 'CATURRA', metodo: 'NATURAL', estado: 'REGISTERED' },
    'LOT-2024-0006': { variedad: 'GEISHA', metodo: 'HONEY', estado: 'CERTIFIED' }
  };
});

When('aplico los filtros: variedad {string}, método {string}, estado {string}', function(variedad, metodo, estado) {
  this.filtrosCombinados = { variedad, metodo, estado };
  this.lotesFiltrados = Object.values(this.lotes).filter(lote =>
    lote.variedad === variedad &&
    lote.metodo === metodo &&
    lote.estado === estado
  );
});

Then('debo ver solo lotes que cumplan todos los criterios', function() {
  this.lotesFiltrados.forEach(lote => {
    if (lote.variedad !== this.filtrosCombinados.variedad ||
        lote.metodo !== this.filtrosCombinados.metodo ||
        lote.estado !== this.filtrosCombinados.estado) {
      throw new Error('Lote no cumple todos los criterios');
    }
  });
});

Then('el sistema debe mostrar {string}', function(resultado) {
  this.resultadoSistema = resultado;
});

// ==================== US11: Eliminación de Lotes ====================

Given('soy un usuario \\(productor o cooperativa) y he identificado un lote erróneo o duplicado', function() {
  this.loteError = {
    codigo: 'LOT-2024-DUPLICADO',
    estado: 'REGISTERED'
  };
  this.lotes[this.loteError.codigo] = this.loteError;
});

When('selecciono la opción de eliminar dicho lote y confirmo la acción', function() {
  this.confirmacionEliminacion = true;
  this.razonEliminacion = 'Lote duplicado';
  if (this.confirmacionEliminacion) {
    delete this.lotes[this.loteError.codigo];
    this.loteEliminado = true;
  }
});

Then('el lote debe ser permanentemente removido de mi base de datos de producción para mantenerla limpia', function() {
  if (this.lotes[this.loteError.codigo]) {
    throw new Error('Lote no eliminado');
  }
});

Given('tengo un lote con código {string} en estado {string}', function(codigo, estado) {
  this.lote = {
    codigo: codigo,
    estado: estado
  };
  this.lotes[codigo] = this.lote;
  this.loteActual = codigo;
});

When('intento eliminar el lote', function() {
  this.intentoEliminacion = true;
  if (this.lote.estado !== 'REGISTERED') {
    this.eliminacionBloqueada = true;
    this.errorEliminacion = true;
  }
});

Given('tengo un lote {string} en estado {string}', function(codigo, estado) {
  this.lote = {
    codigo: codigo,
    estado: estado
  };
  this.lotes[codigo] = this.lote;
  this.loteActual = codigo;
});

Then('debo tener las opciones {string} y {string}', function(opcion1, opcion2) {
  this.opcionesDialogo = [opcion1, opcion2];
});

Then('debo ingresar la razón de eliminación', function() {
  this.formularioRazonVisible = true;
});

Then('el lote debe ser eliminado permanentemente', function() {
  if (this.razonEliminacion && this.confirmacionEliminacion) {
    delete this.lotes[this.loteActual];
    this.loteEliminado = true;
  }
});

When('elimino el lote con razón {string}', function(razon) {
  this.razonEliminacion = razon;
  this.confirmacionEliminacion = true;
  if (this.lote && this.lote.estado === 'REGISTERED') {
    this.auditoriaEliminacion = {
      usuario: this.usuarioActual,
      fecha: new Date(),
      loteEliminado: this.loteActual,
      razon: razon
    };
    delete this.lotes[this.loteActual];
    this.loteEliminado = true;
  }
});

Then('el sistema debe registrar en auditoría:', function(dataTable) {
  if (!this.auditoriaEliminacion) {
    throw new Error('No se registró en auditoría');
  }
  this.camposAuditoria = dataTable.rawTable;
});

// ==================== US13: Análisis de Color ====================

Given('el módulo de análisis está activo', function() {
  this.moduloAnalisisActivo = true;
});

Given('un lote de café de diferentes productores asociados está siendo clasificado', function() {
  this.lote = {
    codigo: 'LOT-2024-0001',
    multiProductor: true,
    estado: 'PROCESSING'
  };
});

When('el sistema realiza el análisis automático', function() {
  this.analisisRealizado = true;
  this.resultadoAnalisis = {
    color: { light: 80, medium: 15, dark: 3, green: 2 },
    tamaño: { pequeño: 10, mediano: 70, grande: 20 }
  };
});

Then('el sistema debe medir objetivamente el color y el tamaño de los granos para estandarizar la calidad entre los lotes', function() {
  if (!this.analisisRealizado || !this.resultadoAnalisis) {
    throw new Error('Análisis no completado');
  }
  this.medicionObjetiva = true;
});

Given('tengo un lote {string} para analizar', function(codigo) {
  this.loteAnalisis = codigo;
  this.lote = {
    codigo: codigo,
    estado: 'PROCESSING',
    imagen: 'imagen_granos.jpg'
  };
});

When('el sistema procesa la imagen', function() {
  this.imagenProcesada = true;
  this.distribucionColor = {
    light: 80,
    medium: 15,
    dark: 3,
    green: 2
  };
});

Then('debe reportar porcentajes de color: Light {string}%, Medium {string}%, Dark {string}%, Green {string}%', function(light, medium, dark, green) {
  const lightNum = parseInt(light);
  const mediumNum = parseInt(medium);
  const darkNum = parseInt(dark);
  const greenNum = parseInt(green);
  
  if (this.distribucionColor.light !== lightNum ||
      this.distribucionColor.medium !== mediumNum ||
      this.distribucionColor.dark !== darkNum ||
      this.distribucionColor.green !== greenNum) {
    throw new Error('Porcentajes de color no coinciden');
  }
});

Then('la suma de porcentajes debe ser aproximadamente {int}%', function(total) {
  const suma = Object.values(this.distribucionColor).reduce((a, b) => a + b, 0);
  if (Math.abs(suma - total) > 2) {
    throw new Error(`Suma incorrecta: ${suma}, esperado: ${total}`);
  }
});

// ==================== US14: Clasificación ====================

Given('el lote ha completado todos los análisis previos', function() {
  this.analisisCompletos = true;
  this.lote = this.lote || { codigo: 'LOT-2024-0001' };
  this.lote.analisisColor = true;
  this.lote.analisisTamaño = true;
  this.lote.deteccionDefectos = true;
});

Given('un lote de café ha completado exitosamente la detección de defectos y el análisis físico', function() {
  this.analisisCompletos = true;
  this.lote = {
    codigo: 'LOT-2024-0001',
    deteccionDefectos: { completado: true, porcentajeDefectos: 2 },
    analisisFisico: { completado: true, color: 'uniforme', tamaño: 'consistente' }
  };
});

When('solicito la clasificación final del lote según estándares de exportación reconocidos', function() {
  this.clasificacionSolicitada = true;
  if (this.analisisCompletos) {
    this.clasificacionFinal = 'Premium';
  }
});

Then('el sistema debe entregar una clasificación automática que me permita acceder a mejores precios en el mercado internacional', function() {
  if (!this.clasificacionFinal) {
    throw new Error('Clasificación no entregada');
  }
  this.accesoMercado = 'internacional';
});

Given('tengo un lote con score de calidad {string}', function(score) {
  this.scoreCalidad = parseInt(score);
  this.lote = {
    codigo: 'LOT-2024-0001',
    scoreCalidad: this.scoreCalidad
  };
});

When('el sistema calcula la clasificación final', function() {
  this.clasificacionCalculada = true;
  
  if (this.scoreCalidad >= 90) {
    this.categoria = 'Specialty';
    this.mercadoObjetivo = 'Exportación Premium';
  } else if (this.scoreCalidad >= 80) {
    this.categoria = 'Premium';
    this.mercadoObjetivo = 'Exportación';
  } else if (this.scoreCalidad >= 70) {
    this.categoria = 'A';
    this.mercadoObjetivo = 'Exportación/Local';
  } else if (this.scoreCalidad >= 60) {
    this.categoria = 'B';
    this.mercadoObjetivo = 'Mercado Local';
  } else {
    this.categoria = 'C';
    this.mercadoObjetivo = 'Procesamiento Industrial';
  }
});

Then('debe asignarse la categoría {string}', function(categoria) {
  if (this.categoria !== categoria) {
    throw new Error(`Categoría incorrecta: esperado ${categoria}, obtenido ${this.categoria}`);
  }
});

Then('debe indicarse el mercado objetivo {string}', function(mercado) {
  if (this.mercadoObjetivo !== mercado) {
    throw new Error(`Mercado objetivo incorrecto: ${this.mercadoObjetivo}`);
  }
});

// ==================== US15: Reportes ====================

Given('soy un productor y he iniciado sesión', function() {
  this.usuarioActual = { 
    tipo: 'PRODUCTOR',
    id: 1,
    nombre: 'Productor Test'
  };
  this.sesionActiva = true;
});

Given('tengo un lote clasificado', function() {
  this.lote = {
    codigo: 'LOT-2024-0001',
    estado: 'CLASSIFIED',
    categoria: 'Premium',
    scoreCalidad: 85,
    porcentajeExportacion: 85,
    porcentajeLocal: 15
  };
  this.loteClasificado = true;
});

Given('soy un productor y un lote ha sido clasificado', function() {
  this.usuarioActual = { tipo: 'PRODUCTOR', nombre: 'Productor Test' };
  this.lote = {
    codigo: 'LOT-2024-0001',
    estado: 'CLASSIFIED',
    categoria: 'Premium',
    porcentajeExportacion: 85,
    porcentajeLocal: 15
  };
  this.loteClasificado = true;
});

When('genero el reporte de clasificación de mi lote', function() {
  if (this.loteClasificado) {
    this.reporteGenerado = true;
    this.reporte = {
      codigoLote: this.lote.codigo,
      categoria: this.lote.categoria,
      porcentajeExportacion: this.lote.porcentajeExportacion,
      porcentajeLocal: this.lote.porcentajeLocal,
      recomendaciones: 'Lote apto para exportación'
    };
  }
});

Then('debo obtener un reporte simple y fácil de entender que muestre claramente el porcentaje de café apto para exportación versus el apto para mercado local', function() {
  if (!this.reporteGenerado) {
    throw new Error('Reporte no generado');
  }
  if (!this.reporte.porcentajeExportacion || !this.reporte.porcentajeLocal) {
    throw new Error('Reporte no contiene información de porcentajes');
  }
  this.reporteSimple = true;
});

Given('tengo un lote clasificado {string}', function(codigo) {
  this.loteActual = codigo;
  this.lote = {
    codigo: codigo,
    estado: 'CLASSIFIED',
    categoria: 'Premium',
    scoreCalidad: 85,
    porcentajeExportacion: 85,
    porcentajeLocal: 15,
    recomendaciones: 'Lote apto para exportación'
  };
  this.loteClasificado = true;
});

When('solicito el reporte en formato {string}', function(formato) {
  this.formatoSolicitado = formato;
  if (this.loteClasificado) {
    this.reporteEnFormatoGenerado = true;
    this.archivoReporte = {
      nombre: `reporte_${this.loteActual}.${formato.toLowerCase()}`,
      formato: formato,
      contenido: this.lote
    };
  }
});

Then('debe generarse un archivo {string} descargable', function(formato) {
  if (!this.reporteEnFormatoGenerado) {
    throw new Error('Archivo no generado');
  }
  if (this.archivoReporte.formato !== formato) {
    throw new Error(`Formato incorrecto: ${this.archivoReporte.formato}`);
  }
});

Then('el reporte debe incluir: categoría, porcentajes, recomendaciones', function() {
  const contenido = this.archivoReporte.contenido;
  if (!contenido.categoria || !contenido.porcentajeExportacion || !contenido.recomendaciones) {
    throw new Error('Reporte no incluye toda la información requerida');
  }
});

// ==================== FUNCIONES AUXILIARES ====================

this.generarCodigoLote = function() {
  const año = new Date().getFullYear();
  const numLotes = Object.keys(this.lotes).length + 1;
  return `LOT-${año}-${String(numLotes).padStart(4, '0')}`;
};

this.registrarLote = function() {
  if (!this.lote) {
    this.lote = {
      fechaCosecha: '2024-05-15',
      variedad: 'TYPICA',
      cantidad: 500,
      metodo: 'WASHED',
      ubicacion: { latitud: -12.0464, longitud: -77.0428 },
      altitud: 1500
    };
  }
  
  // Validaciones
  if (this.campoVacio) {
    this.errorRegistro = true;
    return;
  }
  
  if (this.fechaFutura) {
    this.errorRegistro = true;
    return;
  }
  
  if (this.latitudInvalida || this.longitudInvalida) {
    this.errorRegistro = true;
    return;
  }
  
  if (this.valorInvalido) {
    this.errorRegistro = true;
    return;
  }
  
  // Generar código si no existe
  if (!this.lote.codigo) {
    this.lote.codigo = this.generarCodigoLote();
  }
  
  // Registrar lote
  this.lotes[this.lote.codigo] = this.lote;
  this.loteRegistrado = true;
  this.cambiosGuardados = true;
};