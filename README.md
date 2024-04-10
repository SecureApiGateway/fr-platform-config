# fr-platform-config

This repo contains the configuration to apply to an ID Cloud instance in order for it to run the Secure API Gateway Open Banking edition.

Most of the configuration will be new items that can be added to the config for a particular instance. 
Some files will overwrite existing configuration, for instance [oauth-oidc.json](sapig-overlay/realms/alpha/services/oauth-oidc.json).
It is assumed that configuration will be applied to a new ID Cloud instance that has not had any additional configuration applied.

The config is stored in a directory structure that is realm agnostic, the placeholder "realmName" is used in directories
which are realm dependent. If further realm specific config is required, then following the convention of using "realmName.*"
in the path will produce the desired output when the config is deployed see [Deploying the config](#deploying-the-config)

Example realm specific paths:
- [sapig-overlay/core/realms/realmName](sapig-overlay/core/realms/realmName)
- [sapig-overlay/core/service-objects/realmName_user](sapig-overlay/core/service-objects/realmName_user)

## Deploying the config

The config needs to be deployed using the [fr-config-manager tool](https://github.com/ForgeRock/fr-config-manager)

Run `./create-config-archive.sh` to produce a .tar.gz containing the config.

Args:
- `--type` (mandatory) values at the time of writing can be either `ob` or `core`
- `--realm` (defaults to alpha) the FIDC realm that the config will be deployed to 

Copy the archive to the directory that contains the configuration for the ID Cloud tenant that you wish to deploy to.
Unpack the config archive using `tar -xvf $CONFIG_FILE_NAME`
