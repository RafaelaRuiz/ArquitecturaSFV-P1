# ArquitecturaSFV-P1

# Evaluación Práctica - Ingeniería de Software V

## Información del Estudiante
- **Nombre: Rafaela Ruiz**
- **Código: A00395368**
- **Fecha: 06/08/2025**

## Resumen de la Solución
Para construir la imagen de Docker, utilicé una versión liviana de Node.js como base (node:alpine) con el objetivo de optimizar el tiempo de construcción y reducir el tamaño final de la imagen. Dentro del Dockerfile, incluí únicamente las dependencias necesarias para ejecutar la aplicación, lo que garantiza un entorno limpio y eficiente.

El proceso consistió en copiar los archivos de la aplicación al contenedor, instalar las dependencias mediante npm install, y definir las variables de entorno requeridas (PORT y NODE_ENV) para que el servicio se ejecute correctamente en modo producción. Finalmente, expuse el puerto correspondiente y configuré el comando de inicio de la app.

Una vez construida la imagen, ejecuté el contenedor con los parámetros adecuados, mapeando el puerto local al interno del contenedor, y verifiqué su funcionamiento mediante una petición HTTP (curl) para asegurarme de que el servicio respondía correctamente.

## Dockerfile
Para construir el Dockerfile, decidí utilizar una imagen base liviana de Node.js (node:alpine) con el fin de reducir el tamaño de la imagen y acelerar el proceso de construcción. Esta elección permite que la aplicación se despliegue más rápido y consuma menos recursos.

Dentro del Dockerfile, copié los archivos de la aplicación al contenedor, instalé las dependencias necesarias usando npm install, y definí el puerto de escucha mediante la instrucción EXPOSE. También configuré el comando de inicio con CMD para que la aplicación se ejecute automáticamente al iniciar el contenedor. El enfoque fue mantener el entorno lo más limpio y eficiente posible, incluyendo solo lo esencial para la ejecución en producción.

## Script de Automatización
El script desarrollado en PowerShell automatiza todo el proceso de despliegue. Primero verifica si existe la poliza que permite ejecutar el script. Luego, si Docker está instalado en el sistema. Luego construye la imagen utilizando el Dockerfile, elimina cualquier contenedor previo con el mismo nombre para evitar conflictos, y ejecuta el nuevo contenedor con las variables de entorno necesarias (PORT=3000 y NODE_ENV=production).

Después de iniciar el contenedor, el script espera unos segundos para permitir que el servicio se levante correctamente, y realiza una prueba básica utilizando Invoke-WebRequest para verificar que el servicio responde en el puerto configurado. Finalmente, imprime un resumen del estado del proceso, indicando si fue exitoso o si ocurrió algún error.

Además, el script incluye una verificación de la política de ejecución de PowerShell, ajustándola temporalmente si es necesario para permitir la ejecución del propio script sin intervención manual.

## Principios DevOps Aplicados
1. Automatización del despliegue: Se creó un script que automatiza la construcción de la imagen, ejecución del contenedor y verificación del servicio, reduciendo errores manuales y acelerando el proceso.

2. Integración continua: El uso de un Dockerfile bien estructurado permite integrar fácilmente la aplicación en entornos de desarrollo, prueba o producción.

3. Monitorización y validación: El script incluye una verificación automática del estado del servicio mediante una petición HTTP, asegurando que el sistema responde correctamente tras cada despliegue.

## Captura de Pantalla
Las caturas de pantallas estan en el word

## Mejoras Futuras
[Describe al menos 3 mejoras que podrían implementarse en el futuro]

## Instrucciones para Ejecutar
Solo debe colocar .\deploy.ps1 en powershell en la raiz del directorio de este proyecto: /ArquitecturaSFV-P1
