#!/usr/bin/env bash

echo "Artisan model generator"
echo "Created by Loupeznik (https://github.com/Loupeznik)"

if [[ ! -e './artisan' ]]; then
  echo "[ERROR] Artisan not found in this directory, exiting"
  exit 1
fi

read -p "Enter model names separated by commas: " input

if [ -z $input ]; then
  echo "[ERROR] No model names entered, exiting"
  exit 1
fi

echo "Enter switches to create additional classes, like controllers, no switch will be used if the field is left blank"
echo "Available switches m - migration, s - seeder, f - factory, c - controller (-msfc)"

read -p "Enter desired switches: " switches

if [ -z $switches ]; then
  echo "[WARNING] No switch selected"
else
  if [[ $switches != "-"* ]]; then
    switches="-$switches"
  fi
  if ( echo $switches | grep ! -Eq 'mscf' &> /dev/null ); then
    echo "[ERROR] The switch can contain only [mscf] characters"
    exit 1
  fi
fi

input=${input//[[:space:]]/}
IFS=',' read -ra input_array <<< "$input"

for i in "${input_array[@]}"
do
  echo "[INFO] Creating model ${i}"
  php artisan make:model $i $switches
done
