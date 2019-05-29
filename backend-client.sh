#!/usr/bin/env bash

set -e

if [ -z ${1} ]; then
    echo -e "\nMissing base directory where to place everything.\n"
    exit 1
fi

if [ -z ${2} ]; then
    echo -e "\nMissing Git repository where SAML metadata is stored.\n"
    exit 1
fi

DIR_BASE=${1}
DIR_GIT_REMOTE=${2}
DIR_GIT_REPO=${DIR_BASE}/git

mkdir -p ${DIR_BASE}
cd ${DIR_BASE}

# Using `new` branch, because `master` is still being used by Jagger
git clone -b new https://github.com/CESNET/saml-validator

git clone https://github.com/CESNET/metaman-helpers

git clone ${DIR_GIT_REMOTE} ${DIR_GIT_REPO}
cd ${DIR_GIT_REPO}
git config commit.template .commit-message

ln -s ${DIR_BASE}/metaman-helpers/{pre-commit,commit-msg} ${DIR_GIT_REPO}/.git/hooks

cd ${DIR_BASE}/metaman-helpers
cp config.example config
sed -i -e "s%SAML_VALIDATOR=/path/to/saml-validator/%SAML_VALIDATOR=${DIR_BASE}/saml-validator/%" config

echo -e "\nSet 'user.name', 'user.email' and possibly 'user.signingkey' and 'commit.gpgsign=true'.\n"

