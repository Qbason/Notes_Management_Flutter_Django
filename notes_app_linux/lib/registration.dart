import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final newLogin = TextEditingController();
  final newPassword = TextEditingController();
  final newEmail = TextEditingController();

  void tryRegistration() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Registration"),
          automaticallyImplyLeading: true,
        ),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Registration",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Open Sans',
                            fontSize: 40)),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: newLogin,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Login',
                            hintText: 'Enter your login'),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: newPassword,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'Enter your password'),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: newPassword,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          hintText: 'Enter your email'),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                        onPressed: tryRegistration,
                        child: const Text('Register',
                            style:
                                TextStyle(color: Colors.white, fontSize: 25))),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
