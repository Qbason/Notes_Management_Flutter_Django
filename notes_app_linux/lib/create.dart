import 'package:notes_app_linux/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CreatePage extends StatefulWidget {
  final Client client;

  const CreatePage({
    Key? key,
    required this.client,
  }) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create")),
      body: MainPageCreator(
          controller2: controller2, controller: controller, widget: widget),
    );
  }
}

class MainPageCreator extends StatelessWidget {
  const MainPageCreator({
    Key? key,
    required this.controller2,
    required this.controller,
    required this.widget,
  }) : super(key: key);

  final TextEditingController controller2;
  final TextEditingController controller;
  final CreatePage widget;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            onPressed: () async {
              await widget.client.post(createurlNote(), body: {
                'title': controller.text,
                'content': controller2.text
              });
              Navigator.pop(context, true);
            },
            child: const Text("Create Note"))
      ],
    );
  }
}
