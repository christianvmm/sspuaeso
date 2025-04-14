#!/bin/bash

while true; do
   echo ""
   echo "✨ VMs en VirtualBox"
   VBoxManage list vms
   echo "============================="
   echo "1. Crear una nueva"
   echo "2. Mostrar una VM"
   echo "3. Eliminar una VM"
   echo "4. Listar tipos de SO disponibles"
   echo "5. Salir"
   read -p "Selecciona una opción [1-4]: " option

   case $option in
      1)
         read -p "📝 Nombre: " vm_name
         read -p "🖥️ Tipo de Sistema Operativo: " os_type
         read -p "📦 Número de CPUs: " cpus_count
         read -p "💾 Memoria RAM (GB): " ram_gb
         read -p "💾 Memoria VRAM [1-256MB]: " vram_mb
         read -p "💾 Almacenamiento (GB): " storage_gb
         read -p "💿 Nombre del controlador SATA: " sata_controller_name
         read -p "💿 Nombre del controlador IDE: " ide_controller_name
         
         # creación
         VBoxManage createvm --name $vm_name --ostype $os_type --register

         # añadir cpus, ram y vram
         ram_mb=$((ram_gb * 1024))
         VBoxManage modifyvm $vm_name --cpus $cpus_count --memory $ram_mb --vram $vram_mb

         # Ruta del disco duro dentro de la carpeta de la VM
         vm_folder="$HOME/VirtualBox VMs/$vm_name"
         vdi_path="$vm_folder/${vm_name}.vdi"

         # virtual hard disk
         storage_mb=$((storage_gb * 1024))
         VBoxManage createhd --filename "$vdi_path" --size $storage_mb --variant Standard

         # agregar el controlador de almacenamiento a la VM
         VBoxManage storagectl $vm_name --name $sata_controller_name --add sata --bootable on

         # agregar el virtual hard disk al controlador de almacenamiento
         VBoxManage storageattach $vm_name --storagectl $sata_controller_name --port 0 --device 0 --type hdd --medium "$vdi_path"

         # agregar el controlador IDE
         VBoxManage storagectl $vm_name --name $ide_controller_name --add ide


         echo "📁 Resumen: "
         VBoxManage showvminfo "$vm_name" | grep -E 'Name:|Memory size|VRAM size|Platform Architecture|Number of CPUs|Storage size|Guest OS'
         VBoxManage showvminfo "$vm_name" | awk '/^Storage Controllers:/, /^NIC [0-9]+:/'
         echo ""
         echo "✅ Máquina Virtual Creada. "
         read -p "Presiona una tecla para continuar..."         
         ;;

      2)
         read -p "📝 Nombre de la VM a buscar: " vm_name
         echo "📁 Resumen: "
         VBoxManage showvminfo "$vm_name" | grep -E 'Name:|Memory size|VRAM size|Platform Architecture|Number of CPUs|Storage size|Guest OS'
         VBoxManage showvminfo "$vm_name" | awk '/^Storage Controllers:/, /^NIC [0-9]+:/'
         ;;

      3)
         read -p "❌ Nombre de la VM a eliminar: " vm_name
         vm_folder="$HOME/VirtualBox VMs/$vm_name"
         VBoxManage unregistervm --delete $vm_name
         rm -rf $vm_folder
         ;;

      4)
         echo "🖥️ Tipos de Sistema Operativo Disponibles: "
         VBoxManage list ostypes --sorted --long | awk '/^ID:/ {print $2}'
         ;;

      5)
         echo "Saliendo..."
         break
         ;;
      *)
         echo "Opción no válida. Inténtalo nuevamente."
         ;;
   esac
done
