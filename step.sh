#!/bin/bash

# exit if a command fails
set -e

#
# Required parameters
if [ -z "${manifest_file}" ] ; then
  echo " [!] Missing required input: manifest_file"
  exit 1
fi
if [ ! -f "${manifest_file}" ] ; then
  echo " [!] File doesn't exist at specified AndroidManifest.xml path: ${manifest_file}"
  exit 1
fi

if [ -z "${version_code}" ] ; then
  echo " [!] No version_code specified!"
  exit 1
fi

if [ -z "${version_name}" ] ; then
  echo " [!] No version_name specified!"
  exit 1
fi

# ---------------------
# --- Configs:

echo " (i) Provided Android Manifest path: ${manifest_file}"
echo " (i) Verson Code: ${version_code}"
echo " (i) Version Name: ${version_name}"

# ---------------------
# --- Main:

# verbose / debug print commands
set -v

# ---- Set Build Version Code:

sed -i.bak "s/android:versionCode=\".*\"/android:versionCode=\"${version_code}\"/g" ${manifest_file}

# ---- Set Build Version Code:

sed -i.bak "s/android:versionName=\".*\"/android:versionName=\"${version_name}\"/g" ${manifest_file}

# ---- Remove backup:

rm -f ${manifest_file}.bak

# ==> Build Version changed