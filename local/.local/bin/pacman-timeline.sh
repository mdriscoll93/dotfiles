#!/bin/sh
# Loop through packages explicitly installed
for i in $(pacman -Qe)
do
  # Search your installed packages in pacman.log
  grep "\[ALPM\] installed $i" /var/log/pacman.log
done | \
  sort -u | \
  # Clean the output
  sed -e 's/\[ALPM\] installed //' -e 's/(.*$//'
