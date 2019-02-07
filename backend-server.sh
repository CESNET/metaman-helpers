#!/usr/bin/env bash

DIR_BASE=~/tmp/metaman
DIR_GIT_BARE=${DIR_BASE}/git
DIR_GIT_REPO=${DIR_BASE}/metaman-git

mkdir -p ${DIR_BASE}

cd ${DIR_BASE}
git init --bare ${DIR_GIT_BARE}

# Using `new` branch, because `master` is still being used by Jagger
git clone -b new https://github.com/CESNET/saml-validator

git clone https://github.com/CESNET/metaman-helpers

git clone ${DIR_GIT_BARE} ${DIR_GIT_REPO}
cd ${DIR_GIT_REPO}
ln -s ${DIR_BASE}/metaman-helpers/gitignore .gitignore
git add .gitignore
git commit -m "${USER}: .gitignore (add)"
git push
git config commit.template .commit-message

ln -s ${DIR_BASE}/metaman-helpers/update ${DIR_GIT_BARE}/hooks
ln -s ${DIR_BASE}/metaman-helpers/{pre-commit,commit-msg} ${DIR_GIT_REPO}/.git/hooks

cd ${DIR_BASE}/metaman-helpers
cp config.example config
sed -i '' -e "s%SAML_VALIDATOR=/path/to/saml-validator/%SAML_VALIDATOR=${DIR_BASE}/saml-validator/%" config

