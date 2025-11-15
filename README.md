# Acceptance Tests

## Descripción General

Este directorio contiene las pruebas de aceptación (Gherkin/BDD) para el proyecto BeanDetect, un sistema de clasificación automática de café usando IA.

## Comandos necesarios

Inicializar package.json
```bash
npm init -y
```

Instalar Cucumber (dependencia de desarrollo)
```bash
npm install --save-dev @cucumber/cucumber
```

Instalar dependencias definidas en package.json
```bash
npm install
```

Ejecutar todos los tests
```bash
npm test
```

Ejecutar un feature específico (usar desde la raíz del proyecto acceptance-tests)
```bash
npm test -- features/US01.feature
npm test -- features/US02.feature
npm test -- features/US03.feature
npm test -- features/US04.feature
npm test -- features/US06.feature
npm test -- features/US07.feature
npm test -- features/US08.feature
npm test -- features/US10.feature
npm test -- features/US11.feature
npm test -- features/US13.feature
npm test -- features/US14.feature
npm test -- features/US15.feature
```