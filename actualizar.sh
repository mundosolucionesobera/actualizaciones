#!/system/bin/sh

# =================================================================
# SISTEMA AUTÓNOMO MUNDO SOLUCIONES OBERÁ (VERSIÓN RELEASES)
# =================================================================

CARPETA="/sdcard/MundoSoluciones"
mkdir -p "$CARPETA"

# 1. Leemos el ÚLTIMO lanzamiento (Release) de tu repositorio
URL_API="https://api.github.com/repos/mundosolucionesobera/actualizaciones/releases/latest"

# Extraemos los enlaces directos de cualquier .apk que hayas subido ahí
ENLACES=$(curl -s "$URL_API" | grep '"browser_download_url":' | grep '\.apk"' | cut -d '"' -f 4)

# 2. El motor procesa cada aplicación
for link in $ENLACES; do
    
    # Obtenemos el nombre del archivo
    nombre_archivo="${link##*/}"
    ruta_local="$CARPETA/$nombre_archivo"
    
    # Descargamos la aplicación
    curl -L -o "$ruta_local" "$link"
    
    # Instalamos silenciosamente y borramos el instalador
    if [ -f "$ruta_local" ]; then
        pm install -r "$ruta_local"
        rm "$ruta_local"
    fi
    
done

exit