import 'package:flutter/material.dart';
import 'package:oauth2/oauth2.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:notes_app_linux/create.dart';
import 'package:notes_app_linux/update.dart';
import 'package:notes_app_linux/urls.dart';
import 'note.dart';
import 'package:http/http.dart' as http;

class FirstPage extends StatefulWidget {
  final Client clientWithCredential;
  final title = "Notes";

  const FirstPage({
    Key? key,
    required this.clientWithCredential,
  }) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late Client client;
  List<Note> notes = [];

  @override
  void initState() {
    client = widget.clientWithCredential;
    _getNotes();
    super.initState();
  }

  _getNotes() async {
    notes = [];

    List response =
        json.decode(utf8.decode((await client.readBytes(geturlNotes()))));
    for (var element in response) {
      notes.add(Note.fromMap(element));
    }

    //log(response.join("\n"));

    setState(() {});
  }

  _deleteNote(int id) async {
    await client.delete(deleteurlNote(id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _getNotes();
        },
        child: Center(
          child: Container(
            //width: MediaQuery.of(context).size.width * 0.65,
            decoration: const BoxDecoration(
              border: Border(
                top:
                    BorderSide(width: 1.0, color: Color.fromARGB(255, 0, 0, 0)),
                bottom:
                    BorderSide(width: 1.0, color: Color.fromARGB(255, 0, 0, 0)),
                left:
                    BorderSide(width: 1.0, color: Color.fromARGB(255, 0, 0, 0)),
                right:
                    BorderSide(width: 1.0, color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text(notes[index].title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    onTap: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UpdatePage(
                              client: client,
                              id: notes[index].id,
                              title: notes[index].title,
                              content: notes[index].content)));
                      setState(() {
                        _getNotes();
                      });
                    },
                    subtitle: Text(notes[index].content),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await _deleteNote(notes[index].id);
                        setState(() {
                          _getNotes();
                        });
                      },
                    ),
                    leading: const Icon(Icons.task_sharp));
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final value = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CreatePage(client: client)),
          );
          setState(() {
            if (value != null) {
              _getNotes();
            }
          });
        },
        tooltip: '',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
