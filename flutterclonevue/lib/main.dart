import 'package:flutter/material.dart';
import 'package:flutterclonevue/provider/login_provider.dart';
import 'package:flutterclonevue/provider/task_provider.dart';
import 'package:flutterclonevue/widgets/home.dart';
import 'package:flutterclonevue/widgets/login.dart';
import 'package:flutterclonevue/widgets/register.dart';
import 'package:flutterclonevue/api/api_service.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
          create: (_) => LoginProvider(),
        ),
        Provider<TaskProvider>(create: (_) => TaskProvider([]))
      ],
      child: Consumer<LoginProvider>(builder: (_, loginProvider, __) {
        return MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => loginProvider.homePath
                ? const HomeWidget()
                : const LoginWidget(),
            '/register': (context) => const RegisterWidget(),
          },
          debugShowCheckedModeBanner: false,
        );
      })));
}
