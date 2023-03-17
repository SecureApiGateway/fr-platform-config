var config = {
  realm: "alpha",
  clientId: "atmScript",
  clientSecret: "password",
  trustedGatewayScope: "trusted_gateway"
};


var fr = JavaImporter(
    org.forgerock.oauth2.core.exceptions.InvalidRequestException
);



function tag(message) {
    return "***".concat(scriptName).concat(" ").concat(message);
}

function validateToken(token) {
  
    const requestBody = "client_id=".concat(config.clientId)
                        .concat("&client_secret=").concat(config.clientSecret)
                        .concat("&token=").concat(token);
  
    const uri = "http://am/am/oauth2/realms/root/realms/".concat(config.realm)
                .concat("/introspect");
  
    logger.message(tag("Checking token at " + uri));
    logger.message(tag("Request body " + requestBody));
    var response;

    try {
        var request = new org.forgerock.http.protocol.Request();
        request.setMethod("POST");
        request.setUri(uri);
        request.getHeaders().add("Content-Type","application/x-www-form-urlencoded");
        request.getEntity().setString(requestBody);

        response = httpClient.send(request).get();
    }
    catch (e) {
        logger.error(tag("Exception calling instrospect endpoint " + e));
        return false;
    }

    var responseBody = response.getEntity().getString();
    logger.message(tag("Got raw response " + responseBody));
    var responseData = JSON.parse(responseBody);
  
    logger.message(tag("Got response " + responseData));
  
    return (responseData.active && 
            responseData.scope && 
            (responseData.scope.toString().split(" ").indexOf(config.trustedGatewayScope) !== -1));
}

logger.message(tag("Starting"));

logger.message(tag("Scopes are " + scopes));
scopes.toArray().forEach(function (scope) {
  logger.message(tag(scope));
})

var scopesString = "".concat(scopes);

if (scopesString.indexOf("accounts") !== -1) {
  logger.message(tag("Enforcing access token"));
  logger.message(tag("Request properties " + requestProperties));
  var accessTokens = requestProperties.get("requestParams").get("gateway_authorization");
  if (!accessTokens) {
    logger.error(tag("No gateway authz token parameter"));
    // throw "Authorization error - no authz token parameter";
    throw new fr.InvalidRequestException("No gateway authz token parameter");
  }
  
  var accessToken = accessTokens.get(0);
  if (!accessToken) {
    logger.error(tag("No gateway authz token"));
    // throw "Authorization error - no token";
    throw {
      code : 401,
      message : "Error",
      detail: {
         code: "401",
         description : "Authorization error - no token", 
         severity : "Fatal"
     }
    }
  }
  
  logger.message(tag("Got access token " + accessToken));

  if (!validateToken(accessToken)) {
    logger.error(tag("No gateway authz token"));
    throw "Authorization error - introspect failed";
  }
  
}