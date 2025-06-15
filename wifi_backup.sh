#!/data/data/com.termux/files/usr/bin/bash

# Banner killerkingMD
clear
echo -e "\033[1;31m"
echo "██╗  ██╗██╗██╗     ██╗     ███████╗██████╗ ██╗███╗   ███╗ ██████╗ "
echo "██║ ██╔╝██║██║     ██║     ██╔════╝██╔══██╗██║████╗ ████║██╔═══██╗"
echo "█████╔╝ ██║██║     ██║     █████╗  ██████╔╝██║██╔████╔██║██║   ██║"
echo "██╔═██╗ ██║██║     ██║     ██╔══╝  ██╔═══╝ ██║██║╚██╔╝██║██║   ██║"
echo "██║  ██╗██║███████╗███████╗███████╗██║     ██║██║ ╚═╝ ██║╚██████╔╝"
echo "╚═╝  ╚═╝╚═╝╚══════╝╚══════╝╚══════╝╚═╝     ╚═╝╚═╝     ╚═╝ ╚═════╝ "
echo "               🔐 Wi-Fi Tool Interativo by killerkingMD👑"
echo -e "\033[0m"

# Caminhos
BACKUP_DIR="/sdcard/WiFi_Backup"
OUTPUT_FILE="$BACKUP_DIR/redes_wifi.txt"

# Função: Backup
backup_wifi() {
  mkdir -p "$BACKUP_DIR"
  > "$OUTPUT_FILE"

  echo -e "\n📦 Fazendo backup das redes Wi-Fi..."

  if [ -f /data/misc/wifi/wpa_supplicant.conf ]; then
    cp /data/misc/wifi/wpa_supplicant.conf "$BACKUP_DIR/"
    echo "✅ wpa_supplicant.conf salvo."
  fi

  if [ -f /data/misc/apexdata/com.android.wifi/WifiConfigStore.xml ]; then
    cp /data/misc/apexdata/com.android.wifi/WifiConfigStore.xml "$BACKUP_DIR/"
    echo "✅ WifiConfigStore.xml salvo."
  fi

  echo -e "\n✅ Backup salvo em: $BACKUP_DIR"
}

# Função: Ver senhas
mostrar_senhas() {
  echo -e "\n🔐 Redes Wi-Fi salvas:\n"
  if [ -f "$BACKUP_DIR/wpa_supplicant.conf" ]; then
    echo "📂 wpa_supplicant.conf:" | tee -a "$OUTPUT_FILE"
    grep -E 'ssid=|psk=' "$BACKUP_DIR/wpa_supplicant.conf" | \
      sed 's/ssid=/📶 Rede: /;s/psk=/🔑 Senha: /' | tee -a "$OUTPUT_FILE"
    echo -e "\n" >> "$OUTPUT_FILE"
  fi

  if [ -f "$BACKUP_DIR/WifiConfigStore.xml" ]; then
    echo "📂 WifiConfigStore.xml:" | tee -a "$OUTPUT_FILE"
    grep -E 'SSID|PreSharedKey' "$BACKUP_DIR/WifiConfigStore.xml" | \
      sed 's/<SSID>/📶 Rede: /;s/<\/SSID>//;s/<PreSharedKey>/🔑 Senha: /;s/<\/PreSharedKey>//' | tee -a "$OUTPUT_FILE"
    echo -e "\n" >> "$OUTPUT_FILE"
  fi

  echo -e "\n📝 Senhas salvas em: $OUTPUT_FILE"
}

# Verifica root
if [ "$(id -u)" -ne 0 ]; then
  echo -e "\n🚫 Este script precisa de root (su).\n"
  exit 1
fi

# Menu interativo
while true; do
  echo -e "\n📋 MENU:"
  echo "1️⃣  Fazer Backup Wi-Fi"
  echo "2️⃣  Ver Senhas Salvas"
  echo "3️⃣  Sair"
  echo -n -e "\nEscolha uma opção [1-3]: "
  read opcao

  case $opcao in
    1)
      backup_wifi
      ;;
    2)
      mostrar_senhas
      ;;
    3)
      echo -e "\n👋 Saindo... até logo, killerkingMD👑!\n"
      exit 0
      ;;
    *)
      echo -e "\n❌ Opção inválida."
      ;;
  esac
done
