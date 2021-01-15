#!/usr/bin/env bash

OK=1
CHANGE=0

URL="https://www.alchemistowl.org/pocorgtfo/"

wget -nc "${URL}"

# MD5 Checksum
md5Checksum="^MD5[[:space:]]\((pocorgtfo[0-9]{2}.pdf)\)[[:space:]]=[[:space:]]([a-z0-9]{32}).*$"

md5FileChecksum="^([a-z0-9]{32}).*$"

while IFS= read -r line; do
  if [[ $line =~ $md5Checksum ]]
  then
    if [[ ! -f ${BASH_REMATCH[1]} ]]
    then
      CHANGE=1
      echo "Downloading ${BASH_REMATCH[1]}"
      wget "${URL}${BASH_REMATCH[1]}"
      if [[ $(md5sum "${BASH_REMATCH[1]}") =~ $md5FileChecksum ]]; then
        echo "Checksum is good"
      else
        echo "Checksum is bad"
        OK=0
      fi
    fi
  fi
done < index.html

if [[ $OK && $CHANGE ]]; then
  git add .
  git commit -m "Automatic update to repo"
  git push origin main
fi
