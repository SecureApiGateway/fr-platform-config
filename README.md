# fr-platform-config

This repo contains the configuration to apply to an ID Cloud instance in order for it to run the Secure API Gateway Open Banking edition.

Most of the configuration will be new items that can be added to the config for a particular instance. 
Some files will overwrite existing configuration, for instance [oauth-oidc.json](sapig-overlay/realms/alpha/services/oauth-oidc.json).
It is assumed that configuration will be applied to a new ID Cloud instance that has not had any additional configuration applied.

## Deploying the config

The config needs to be deployed using the `cs_config_manager` tool

Run `./create-config-archive.sh` to produce a .tar.gz containing the config.

Copy the archive to the directory that contains the configuration for the ID Cloud tenant that you wish to deploy to.
Unpack the config archive using `tar -xvf $CONFIG_FILE_NAME`


