# fr-platform-config

This repo contains the configuration to apply to an ID Cloud instance in order for it to run the Secure API Gateway Open Banking edition.

Most of the configuration will be new items that can be added to the config for a particular instance. 
Some files will overwrite existing configuration, for instance [oauth-oidc.json](sapig-overlay/realms/alpha/services/oauth-oidc.json).
It is assumed that configuration will be applied to a new ID Cloud instance that has not had any additional configuration applied.
