import 'package:flutter/material.dart';
import 'package:flutterclonevue/api/api_service.dart';
import 'package:flutterclonevue/widgets/bottom_sheet_dialog.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  //Form controller
  final TextEditingController usernameReg = TextEditingController();
  final TextEditingController passwordReg = TextEditingController();
  final TextEditingController firstnameReg = TextEditingController();
  final TextEditingController lastnameReg = TextEditingController();
  //Dialog property
  var textDialog = "";
  var _isShow = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    //Data of form
    var data = {};
    var api = ApiService();
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
                    child: Text("REGISTER",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ))),
                TextFormField(
                  decoration:
                      const InputDecoration(hintText: "Enter firstname"),
                  controller: firstnameReg,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: "Enter lastname"),
                  controller: lastnameReg,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: "Enter username"),
                  controller: usernameReg,
                ),
                TextFormField(
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: const InputDecoration(
                    hintText: "Enter password",
                  ),
                  controller: passwordReg,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          data['username'] = usernameReg.text;
                          data['password'] = passwordReg.text;
                          data['firstName'] = firstnameReg.text;
                          data['lastName'] = lastnameReg.text;
                          var registerOk = await api.register(data);
                          print(registerOk);
                          if (registerOk) {
                            Navigator.pop(context);
                          } else {
                            _isShow = true;
                            textDialog = "Dang ky that bai";
                            setState(() {});
                          }
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
          ),
        ),
        bottomSheet: _showBottomSheet(textDialog));
  }

  Widget? _showBottomSheet(text) {
    if (_isShow) {
      return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            height: 100,
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              children: [
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
