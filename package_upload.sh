#!/usr/bin/env bash

echo Copy packages to specified folder and upload them to aem server

ROOT_PATH_DEFAULT="<root of code>"
read -e -p "Enter project root path [$ROOT_PATH_DEFAULT]: " ROOT_PATH
ROOT_PATH="${ROOT_PATH:-$ROOT_PATH_DEFAULT}"

TMP_FOLDER_DEFAULT="/tmp"
read -e -p "Enter path to copy the files to [$TMP_FOLDER_DEFAULT]: " TMP_FOLDER
TMP_FOLDER="${TMP_FOLDER:-$TMP_FOLDER_DEFAULT}"

PROJECT_VERSION_DEFAULT=$(mvn -f ../pom.xml -q -Dexec.executable="echo" -Dexec.args='${project.version}' --non-recursive exec:exec)
read -e -p "Enter version to upload [$PROJECT_VERSION_DEFAULT]: " PROJECT_VERSION
PROJECT_VERSION="${PROJECT_VERSION:-$PROJECT_VERSION_DEFAULT}"

USERNAME_DEFAULT=""
read -e -p "Enter username [$USERNAME_DEFAULT]: " USERNAME
USERNAME="${USERNAME:-$USERNAME_DEFAULT}"

PASSWORD_DEFAULT=""
read -e -s -p "Enter password [$PASSWORD_DEFAULT]: " PASSWORD
PASSWORD="${PASSWORD:-$PASSWORD_DEFAULT}"
echo

PERMISSION_DEFAULT="n"
read -e -p "Deploy Permissions y or n [$PERMISSION_DEFAULT] " PERMISSION
PERMISSION="${PERMISSION:-$PERMISSION_DEFAULT}"

AEM_LOGIN=$USERNAME:$PASSWORD

AUTHOR=http://localhost:4502
PUBLISH=http://localhost:4503
SERVER=($AUTHOR $PUBLISH)

SERVICE_TOKEN=/libs/granite/csrf/token.json
FLUSH_URL=/etc/acs-commons/dispatcher-flush/dispatcher/jcr:content/configuration.flush.html
FLUSH_SERVER=$AUTHOR

PACKAGES=(module1 module2)
echo

function copyPackage {
	echo copy $1/$2/target/$2-$PROJECT_VERSION.zip
    cp $1/$2/target/$2-$PROJECT_VERSION.zip $TMP_FOLDER
}

function uploadPackage {
	filePath=$TMP_FOLDER/$1-$PROJECT_VERSION.zip
	for s in ${SERVER[@]}; do
	    echo upload $s
		curl -u $AEM_LOGIN -F file=@"$filePath" -F name="$1" -F force=true -F install=true $s/crx/packmgr/service.jsp -o $TMP_FOLDER/$1.log
	done
}

echo copy packages to $TMP_FOLDER
for i in ${PACKAGES[@]}; do
  copyPackage $ROOT_PATH $i
done

echo upload packages to server $server
for i in ${PACKAGES[@]}; do
	uploadPackage $i
done

echo flush dispatcher cache
AEM_TOKEN="$(curl -s -H User-Agent:curl -H Referer:${FLUSH_SERVER} -u ${AEM_LOGIN} ${FLUSH_SERVER}${SERVICE_TOKEN}  | sed -e 's/[{"token":}]/''/g')"
LOCATION=$( curl -s -u ${AEM_LOGIN} -X POST -F ':cq_csrf_token:=${AEM_TOKEN}' -D - ${FLUSH_SERVER}${FLUSH_URL} -o /dev/null | grep Location )
if [[ $LOCATION == *"/flush-publish/true/flush/true"* ]]
then
	echo "flush done" 
else
	echo "something went wrong"
fi
