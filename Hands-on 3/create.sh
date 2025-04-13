#!/bin/bash

echo "Hello World"
touch mytext.txt
echo "Hola Mundo" >> mytext.txt

echo "✅ Contenido de mytext.txt: "
cat mytext.txt

echo "✅ Moviendo text a backup"
mkdir backup
mv mytext.txt backup/

echo "✅ Contenido de backup:"
ls backup
read -p "Presiona Enter para continuar..."

echo "✅ Eliminar archivo y carpeta:"
cd backup
rm mytext.txt
cd ..
rm -rf backup
