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

# ---------------------
# --- Configs:

echo " (i) Provided Android Manifest path: ${manifest_file}"
echo " (i) Verson Code: ${version_code}"
if ! [ -z "${version_name}" ] ; then
  echo " (i) Version Name: ${version_name}"
fi

VERSIONCODE=`grep versionCode ${manifest_file} | sed 's/.*versionCode="//;s/".*//'`
VERSIONNAME=`grep versionName ${manifest_file} | sed 's/.*versionName\s*=\s*\"\([^\"]*\)\".*/\1/g'`

if [ -z "${VERSIONCODE}" ] ; then
  echo " [!] Could not find current Version Code!"
  exit 1
fi

echo "Version code detected: ${VERSIONCODE}"
if [ ! -z "${version_code_offset}" ] ; then
  echo " (i) Version code offset: ${version_code_offset}"

  CONFIG_new_version_code=$((${version_code} + ${version_code_offset}))
else
  CONFIG_new_version_code=${version_code}
fi

echo " (i) Version code: ${CONFIG_new_version_code}"


if [ -z "${VERSIONNAME}" ] ; then
  echo " [!] Could not find current Version Name!"
  exit 1
fi
echo "Version name detected: ${VERSIONNAME}"


# ---------------------
# --- Main:

# verbose / debug print commands

set -v
# ---- Set Build Version Code:

sed -i.bak "s/android:versionCode="\"${VERSIONCODE}\""/android:versionCode="\"${CONFIG_new_version_code}\""/" ${manifest_file}

# ---- Set Build Version Code if it was specified:
if ! [ -z "${version_name}" ] ; then
  sed -i.bak "s/android:versionName="\"${VERSIONNAME}\""/android:versionName="\"${version_name}\""/" ${manifest_file}
fi


# ---- Remove backup:

rm -f ${manifest_file}.bak

# ==> Build Version changed
