#!/bin/bash

# Version de este proyecto
version=v_0.0.1

# Mostrar el cuadro de diálogo para ingresar el proyecto del proyecto
proyecto=$(zenity --entry \
    --title "AutoFolder - $version" \
    --text "Ingrese el nombre del proyecto:" \
    --width=350 \
    --ok-label "Siguiente" \
    --cancel-label "Cancelar" )

# Verificar si se ingresó un nombre de proyecto
if [ -z "$proyecto" ]; then
    zenity --info --title "AutoFolder - $version" \
    --text "No se ingresó un nombre de proyecto, el programa se detiene sin cambios."
    exit 1
fi

# Mostrar el cuadro de diálogo para seleccionar la ubicación
ubicacion=$(zenity --file-selection --directory \
    --title "Seleccione la ubicación para guardar el proyecto" )

# Verificar si se seleccionó una ubicación
if [ -z "$ubicacion" ]; then
    zenity --info --title "AutoFolder - $version" \
    --text "No se seleccionó una ubicación, el programa se detiene sin cambios."
    exit 1
fi

# Crear la carpeta principal en la ubicación seleccionada
carpeta_proyecto="$ubicacion/$proyecto"
mkdir "$carpeta_proyecto"
cd "$carpeta_proyecto"

# Crear las subcarpetas
mkdir "1 Mapas"
mkdir "2 Raster"   
mkdir "3 Vectorial"
cd "3 Vectorial"
mkdir "0_ORIGINALES $proyecto"

mkdir "1 ${proyecto}_EPSG5347"
cd "1 ${proyecto}_EPSG5347"
mkdir "1 Limites $proyecto"\
    "2 Vertices $proyecto"\
    "3 Habilitacion_a_regularizar $proyecto"\
    "4 Vertices_habilitacion_a_regularizar $proyecto"\
    "5 Parcelas_inventario $proyecto"\
    "6 Centroides_Parcelas_inventario $proyecto"\
    "7 Fisonomias $proyecto"\
    "8 Fisonomias_habilitacion_a_regularizar $proyecto"\
    "9 Influencia_50km $proyecto"
cd ..

mkdir "2 ${proyecto}_EPSG4326"
cd "2 ${proyecto}_EPSG4326"
mkdir "1 Limites $proyecto"\
    "2 Vertices $proyecto"\
    "3 Habilitacion_a_regularizar $proyecto"\
    "4 Vertices_habilitacion_a_regularizar $proyecto"\
    "5 Parcelas_inventario $proyecto"\
    "6 Centroides_Parcelas_inventario $proyecto"\
    "7 Fisonomias $proyecto"\
    "8 Fisonomias_habilitacion_a_regularizar $proyecto"\
    "9 Influencia_50km $proyecto"

# Mostrar un mensaje de éxito
zenity --info \
    --title "AutoFolder - $version" \
    --width=350 \
    --text "El proyecto: <b>'$proyecto'</b> \nCreado en: <b>'$ubicacion'</b> \n \nFinalizó con éxito!"
