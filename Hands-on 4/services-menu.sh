#!/bin/bash

while true; do
   echo ""
   echo "===== MENÚ DE SERVICIOS ====="
   echo "1. Listar contenido de un fichero (carpeta)"
   echo "2. Crear archivo de texto"
   echo "3. Comparar dos archivos"
   echo "4. Usar de 'awk'"
   echo "5. Usar de 'grep'"
   echo "6. Salir"
   echo "============================="
   read -p "Selecciona una opción [1-6]: " opcion

   case $opcion in
      1)
         read -p "📁 Introduce la ruta absoluta de la carpeta: " ruta
         if [ -d "$ruta" ]; then
               echo "Contenido de $ruta:"
               ls -la "$ruta"
         else
               echo "La ruta no es una carpeta válida."
         fi
         ;;
      2)
         read -p "📁 Introduce la ruta del archivo a crear: " ruta
         read -p "Escribe el texto a guardar: " texto
         echo "$texto" > "$ruta"
         echo "Archivo '$ruta' creado con éxito."
         ;;
      3)
         read -p "📁 Introduce la ruta del primer archivo: " archivo1
         read -p "📁 Introduce la ruta del segundo archivo: " archivo2
         if [[ -f "$archivo1" && -f "$archivo2" ]]; then
               echo "Comparación entre archivos:"
               diff "$archivo1" "$archivo2"
         else
               echo "Uno o ambos archivos no existen."
         fi
         ;;
      4)
         echo ""
         echo "Demostración de AWK: Mostrar la segunda columna de un archivo"
         read -p "Introduce la ruta del archivo: " archivo_awk
         if [[ -f "$archivo_awk" ]]; then
               echo "Mostrando segunda columna:"
               awk '{print $2}' "$archivo_awk"
         else
               echo "Archivo no encontrado."
         fi
         ;;
      5)
         echo ""
         echo "Demostración de GREP: Buscar una palabra clave en un archivo"
         read -p "Introduce la palabra clave a buscar: " palabra
         read -p "Introduce la ruta del archivo: " archivo_grep
         if [[ -f "$archivo_grep" ]]; then
               echo "Líneas que contienen '$palabra':"
               grep "$palabra" "$archivo_grep"
         else
               echo "Archivo no encontrado."
         fi
         ;;
      6)
         echo "Saliendo..."
         break
         ;;
      *)
         echo "Opción no válida. Inténtalo nuevamente."
         ;;
   esac
done
