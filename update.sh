#!/usr/bin/env bash
URL="https://www.alchemistowl.org/pocorgtfo/"
rm *.pdf *.txt *.html
wget -nd -r --show-progress --progress=bar:force:noscroll "${URL}"
git add .
git commit -m "Automatic update"
git push
