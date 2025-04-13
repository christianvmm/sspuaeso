@echo off
echo Creando el archivo mytext.txt
echo Hola Mundo > mytext.txt

echo.
echo Mostrar el contenido de mytext.txt:
type mytext.txt

echo.
echo Creando el subdirectorio "backup"...
mkdir backup

echo.
echo Copiando mytext.txt a backup...
copy mytext.txt backup\

echo.
echo Listando el contenido de backup:
dir backup

pause

echo.
echo Eliminando el archivo mytext.txt...
del backup\mytext.txt

pause

echo.
echo Eliminando el subdirectorio backup...
rmdir backup

echo.
echo Completo.

pause