# metaman-helpers

This repository contains server-side (`update`) and client-side (`pre-commit` and `commit-msg`) Git hooks and a `.gitignore` file for [MetaMan][] which is in development. The hooks depend on [SAML-validator][] to validate SAML metadata against rules of the Czech Academic Identity Federation [eduID.cz][] operated by [CESNET][].

## Installation

After cloning this repository using `git clone` command it is necessary to link the hooks and `.gitignore` to appropriate locations and also set a commit template in the local Git repository hosting SAML metadata with the following command. There are two scripts that helps with that. One is for server-side (`backend-server.sh`) and the other is for client-side (`backend-client.sh`) as described below.

It is also necessary to clone [SAML-validator][], rename `config.example` to `config` and set variable `SAML_VALIDATOR` to a location where you cloned [SAML-validator][].

## Inventory

* `update`
  > A server-side hook. It checks the commit message format against a regular expression defined in `config` file and also validates the metadata using _SAML-validator_.

* `pre-commit`
  > A client-side hook. It validates metadata to be commited to a revision using _SAML-validator_ and if metadata pass the test, it also prepares the commit message according to required format.

* `commit-msg`
  > A client-side hook. It checks the commit message against a regular expression defined in `config` file.

* `gitignore`
  > A file to be renamed to `.gitignore` and placed to local Git repository containing SAML metadata.

* `config.example`
  > An example configuration file containing a regular expression for commit message format and a path to _SAML-validator_.

* `backend-server.sh`
  > A script to build a server's backend, i.e. a server where [MetaMan][] is going to be installed. It creates Git repositories, symlinks hooks, prepares `config` file and clones SAML-validator.

* `backend-client.sh`
  > A script to build a client's backend so that a local Git repository with SAML metadata is available. It also symlinks hooks, prepares `config` file and clones SAML-validator.

[MetaMan]: https://github.com/JanOppolzer/metaman
[SAML-validator]: https://github.com/JanOppolzer/saml-validator
[eduID.cz]: https://www.eduid.cz
[CESNET]: https://www.cesnet.cz

