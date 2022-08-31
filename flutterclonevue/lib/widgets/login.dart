import 'package:flutter/material.dart';
import 'package:flutterclonevue/api/api_service.dart';
import 'package:flutterclonevue/provider/login_provider.dart';
import 'package:provider/provider.dart';
import 'register.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);
  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool loginBtn = false;
  @override
  void initState() {
    setState(() {
      loginBtn = false;
    });
  }

  //Dialog property
  var textDialog = "";
  var _isShow = false;

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var data = {};
    var api = ApiService();
    return Consumer<LoginProvider>(builder: (_, loginProvider, __) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
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
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          data['username'] = username.text;
                          data['password'] = password.text;
                          setState(() {
                            loginBtn = true;
                          });
                          var loginOk = await api.login(data);
                          if (loginOk) {
                            setState(() {
                              loginBtn = false;
                            });
                            loginProvider.changeHomePathToHome();
                            Navigator.pushNamed(context, '/');
                          } else {
                            setState(() {
                              loginBtn = false;
                            });
                            _isShow = true;
                            textDialog =
                                "Dang nhap that bai, sai tai khoan hoac mat khau";
                            setState(() {});
                          }
                        },
                        child: !loginBtn
                            ? const Text('Login')
                            : const Padding(
                                padding: EdgeInsets.all(4),
                                child: CircularProgressIndicator(
                                  color: Colors.amber,
                                ),
                              )),
                    const SizedBox(
                      width: 20,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text("Register"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomSheet: _showBottomSheet(textDialog),
      );
    });
  }

  Widget? _showBottomSheet(text) {
    if (_isShow) {
      return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            height: 120,
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(text),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    _isShow = false;
                    setState(() {});
                  },
                  child: const Text("Close"),
                ),
              ],
            ),
          );
        },
      );
    } else {
      return null;
    }
  }
}
