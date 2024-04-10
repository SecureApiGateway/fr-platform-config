# fr-platform-config

This repo contains the configuration to apply to an ID Cloud instance in order for it to run the Secure API Gateway Open Banking edition.

Most of the configuration will be new items that can be added to the config for a particular instance. 
Some files will overwrite existing configuration, for instance [oauth-oidc.json](sapig-overlay/realms/alpha/services/oauth-oidc.json).
It is assumed that configuration will be applied to a new ID Cloud instance that has not had any additional configuration applied.

The config is stored in a directory structure which assumes the alpha realm in ID Cloud is being used, see 
[Deploying to the bravo realm](#deploying-to-the-bravo-realm) for instructions on how to use the bravo realm.

## Deploying the config

The config needs to be deployed using the [fr-config-manager tool](https://github.com/ForgeRock/fr-config-manager)

Run `./create-config-archive.sh [SAPIG_TYPE]` to produce a .tar.gz containing the config.

`SAPIG_TYPE` values at the time of writing can be either `ob` or `core`

Copy the archive to the directory that contains the configuration for the ID Cloud tenant that you wish to deploy to.
Unpack the config archive using `tar -xvf $CONFIG_FILE_NAME`

### Deploying to the bravo realm

The config in this repo is stored in a directory structure which assumes the alpha realm is being used.

SAPI-G can be installed in either the alpha or bravo realm.

To use bravo, simply rename the realms/alpha directory to realms/bravo in the deployment config archive.

Ensure that the ESV which controls the realm is set to bravo when pushing the config:
- esv-sapig-core-identity-cloud-realm controls core realm
- esv-sapig-ob-identity-cloud-realm controls ob realm
