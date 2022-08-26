import 'dart:io';

// import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

getCredential(String username, String password) async {
  final authorizationEndpoint = Uri.http("127.0.0.1:8000", "o/token/");
  const identifier = 'Jg6HqkKO4iMOtSIVEWKkMKimdBvQ6SLmZptObyl7';
  const secret =
      'U7QXJYzqOEM97EZX38DTqyYHlQRKQp3VbZ1ymSh8vGZx2UQWkWyPX9UTzEYdGXAYwlTAoLU4m2pUVzwD8BXtKFlesWKiuxPQXMYTClgHTppb0OufoOWolvQHD4A29hET';

  // Make a request to the authorization endpoint that will produce the fully
  // authenticated Client.
  oauth2.Client client = await oauth2.resourceOwnerPasswordGrant(
      authorizationEndpoint, username, password,
      identifier: identifier, secret: secret);

  //debugPrint(client.credentials.accessToken.toString());

  return client;
}
