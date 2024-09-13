#!/bin/bash

# Verifica si se pasaron los parámetros correctos
if [ "$#" -lt 2 ]; then
  echo "Uso: $0 <URL> <wordlist_path> [--proxy <proxy_url>]"
  exit 1
fi

URL="$1"
WORDLIST_PATH="$2"
PROXY=""

# Comprueba si se proporcionó un proxy
while [[ "$#" -gt 0 ]]; do
  case $1 in
  --proxy)
    PROXY="--proxy $2"
    shift
    ;;
  *) ;;
  esac
  shift
done

# Verifica que el archivo de wordlist existe
if [ ! -f "$WORDLIST_PATH" ]; then
  exit 1
fi

# Realiza el fuzzing
while IFS= read -r path; do
  response=$(curl -s -o /dev/null -w "%{http_code}" "$URL/$path" $PROXY)
  if [ "$response" == "200" ]; then
    echo "Ruta válida encontrada: $URL/$path : $response"
  fi
done <"$WORDLIST_PATH"
