import 'package:notes_app_linux/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdatePage extends StatefulWidget {
  final Client client;
  final int id;
  final String title;
  final String content;

  const UpdatePage(
      {Key? key,
      required this.client,
      required this.id,
      required this.title,
      required this.content})
      : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  void initState() {
    controller.text = widget.title;
    controller2.text = widget.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update")),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                    hintText: 'Enter title of note'),
              )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: controller2,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Content',
                    hintText: 'Enter content of note'),
              )),
          ElevatedButton(
              onPressed: () {
                widget.client.put(updateurlNote(widget.id), body: {
                  'title': controller.text,
                  'content': controller2.text
                });
                Navigator.pop(context);
              },
              child: const Text("Update Note"))
        ],
      ),
    );
  }
}
