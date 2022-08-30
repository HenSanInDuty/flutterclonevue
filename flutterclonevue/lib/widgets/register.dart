import 'package:flutter/material.dart';
import 'package:flutterclonevue/api/api_service.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController firstname = TextEditingController();
    TextEditingController lastname = TextEditingController();
    TextEditingController email = TextEditingController();
    var data = {};
    var api = ApiService();
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: height / 10,
          ),
          const Center(
              child: Text("REGISTER",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ))),
          TextFormField(
            decoration: const InputDecoration(hintText: "Enter firstname"),
            controller: firstname,
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: "Enter lastname"),
            controller: lastname,
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: "Enter email"),
            controller: email,
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: "Enter username"),
            controller: username,
          ),
          TextFormField(
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              hintText: "Enter password",
            ),
            controller: password,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    data['username'] = username.text;
                    data['password'] = password.text;
                    var loginOk = await api.login(data);
                  },
                  child: const Text('Register')),
              const SizedBox(
                width: 20,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Back"),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
