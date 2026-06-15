#!/system/bin/sh

# =================================================================
# SCRIPT DE ACTUALIZACIÓN REMOTA - MUNDO SOLUCIONES OBERÁ
# =================================================================

# 1. Definimos la carpeta de trabajo en el TV Box
CARPETA="/sdcard/MundoSoluciones"
mkdir -p "$CARPETA"

# =================================================================
# ⬇️ ZONA DE DESCARGAS (Esto es lo ÚNICO que vas a editar a futuro) ⬇️
# =================================================================

# Para mandar una app nueva, simplemente agregás una línea como esta:
# curl -L -o "$CARPETA/nombre_archivo.apk" "ENLACE_RAW_DE_GITHUB"

# Ejemplo real (Podés borrar o cambiar esta línea cuando subas tu primera app):
# curl -L -o "$CARPETA/mi_app.apk" "https://raw.githubusercontent.com/mundosolucionesobera/actualizaciones/main/mi_app.apk"


# =================================================================
# ⚙️ ZONA DEL MOTOR AUTOMÁTICO (NO tocar de acá para abajo) ⚙️
# =================================================================

# El sistema busca cualquier .apk en la carpeta, lo instala y lo borra
for archivo in "$CARPETA"/*.apk; do
    if [ -f "$archivo" ]; then
        
        # Instala la app de forma silenciosa conservando los datos
        pm install -r "$archivo"
        
        # Borra el instalador para no ocupar espacio al cliente
        rm "$archivo"
        
    fi
done

# (Opcional) Limpia la carpeta por si quedó basura
rm -rf "$CARPETA"/*

exit