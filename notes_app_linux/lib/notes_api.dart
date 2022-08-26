import 'dart:convert';
import 'package:notes_app_linux/urls.dart';

Future<List> getNotes(var client) async {
  List response = json.decode((await client.post(geturlNotes())));

  return response;
}
