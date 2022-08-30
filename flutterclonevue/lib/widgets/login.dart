import 'package:flutter/material.dart';
import 'package:flutterclonevue/api/api_service.dart';

class LoginWidget extends StatefulWidget {
  
  const LoginWidget({Key? key}) : super(key: key);
  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool loginBtn = false;
  @override
  void initState(){
    setState(() {
      loginBtn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    var data ={};
    var api = ApiService();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: height / 10,
          ),
          const Center(
              child: Text("LOGIN",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ))),
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
          Row(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    data['username'] = username.text;
                    data['password'] = password.text;
                    var loginOk = await api.login(data);
                  },
                  child: const Text('Login'
                  )),
              const SizedBox(
                width: 20,
              ),
              OutlinedButton(
                onPressed: () {},
                child: Text("Register"),
              )
            ],
          ),
        ],
      ),
    );
  }
}

