#!/usr/bin/env bash
URL="https://www.alchemistowl.org/pocorgtfo/"
wget -r "${URL}"
git add .
git commit -m "Automatic update to repo"
git push
