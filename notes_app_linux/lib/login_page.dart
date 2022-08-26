import 'package:notes_app_linux/first_page.dart';
import 'package:notes_app_linux/validation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:first_project/urls.dart';
import 'package:notes_app_linux/oauth2_login.dart';
import 'package:oauth2/oauth2.dart';
// import 'package:first_project/notes_api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  http.Client client = http.Client();

  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool showInfoBadCredential = false;

  void routeToNewLoggedPage(Client client) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FirstPage(clientWithCredential: client)));
  }

  void checkLoginAndPassword() async {
    String username = usernamecontroller.text;
    String password = usernamecontroller.text;

    if (checkIfStringIsNotEmpty(username) &&
        checkIfStringIsNotEmpty(password)) {
      try {
        Client client = await getCredential(
            usernamecontroller.text, passwordcontroller.text);

        setState(() {
          showInfoBadCredential = false;
        });

        routeToNewLoggedPage(client);
      } on AuthorizationException {
        setState(() {
          showInfoBadCredential = true;
        });
      }
    }

    //var notes = getNotes(client);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Log in page"),
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            width: 190,
            padding: const EdgeInsets.only(top: 40),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(200)),
            child: Center(child: Image.asset('asset/images/flutter.png')),
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: usernamecontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                    hintText: 'Enter valid user name'),
              )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: passwordcontroller,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter your secure password',
                ),
              )),
          TextButton(
              onPressed: () {
                //debugPrint("Hello");
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              )),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: TextButton(
                onPressed: checkLoginAndPassword,
                child: const Text('Login',
                    style: TextStyle(color: Colors.white, fontSize: 25))),
          ),
          showInfoBadCredential
              ? const BadCredentials()
              : const GoodCredentials(),
          const Expanded(
            child: Align(
              alignment: FractionalOffset(0.5, 0.1),
              child: Text('New User? Create Account'),
            ),
          ),
        ],
      ),
    );
  }
}

class GoodCredentials extends StatelessWidget {
  const GoodCredentials({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(0),
      child: Text(""),
    );
  }
}

class BadCredentials extends StatelessWidget {
  const BadCredentials({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(15.0),
      child: Text(
        "Niepoprawne dane logowania",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
    );
  }
}
