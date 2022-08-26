// var baseurl = "jakubk.pl:81";
var baseurl = "127.0.0.1:8000";

Uri geturlToken() {
  String url = "o/token/";
  return Uri.http(baseurl, url);
}

Uri geturlNotes() {
  String url = "notes/";

  return Uri.http(baseurl, url);
}

Uri createurlNote() {
  String url = "notes/";

  return Uri.http(baseurl, url);
}

Uri geturlNote(int id) {
  String url = "notes/$id/";

  return Uri.http(baseurl, url);
}

Uri updateurlNote(int id) {
  String url = "notes/$id/";

  return Uri.http(baseurl, url);
}

Uri deleteurlNote(int id) {
  String url = "notes/$id/";

  return Uri.http(baseurl, url);
}
