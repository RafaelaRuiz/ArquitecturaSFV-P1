# Configuración
$ImageName = "app"
$ContainerName = "app-container"
$Port = 8080

# Verificar y ajustar política de ejecución si es necesario
$currentPolicy = Get-ExecutionPolicy
if ($currentPolicy -eq "Restricted") {
    Write-Host "La política de ejecución está restringida. Cambiando a 'Bypass' temporalmente..."
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
}

# Verificar si Docker está instalado
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "Docker no está instalado. Instálalo antes de continuar."
    exit 1
}

Write-Host "Docker está instalado."

# Construir la imagen
Write-Host "Construyendo la imagen Docker..."
docker build -t $ImageName .
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error al construir la imagen."
    exit 1
}

# Eliminar contenedor previo si existe
Write-Host "Eliminando contenedor anterior si existe..."
docker rm -f $ContainerName | Out-Null

# Ejecutar el contenedor
Write-Host "Ejecutando el contenedor..."
docker run -d -p "$Port`:3000" --name $ContainerName -e PORT=3000 -e NODE_ENV=production $ImageName
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error al iniciar el contenedor."
    exit 1
}

# Esperar unos segundos para que el servicio se inicie
Start-Sleep -Seconds 3

# Verificar que el servicio responde
Write-Host "Verificando respuesta del servicio..."
try {
    $response = Invoke-WebRequest -Uri "http://localhost:$Port" -UseBasicParsing -TimeoutSec 5
    if ($response.StatusCode -eq 200) {
        Write-Host "El servicio respondió correctamente con código HTTP 200."
        $status = "Éxito"
    } else {
        Write-Host "El servicio respondió con código HTTP: $($response.StatusCode)"
        $status = "Error"
    }
} catch {
    Write-Host "No se pudo conectar al servicio. Error: $($_.Exception.Message)"
    $status = "Error"
}

# Resumen
Write-Host "`nResumen:"
Write-Host "Imagen: $ImageName"
Write-Host "Contenedor: $ContainerName"
Write-Host "Puerto: $Port"
Write-Host "Estado: $status"
