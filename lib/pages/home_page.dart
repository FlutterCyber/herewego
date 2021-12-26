import 'package:flutter/material.dart';
import 'package:herewego/pages/sign_in_page.dart';
import 'package:herewego/pages/sign_up_page.dart';
import 'package:herewego/services/auth_service.dart';

class HomePage extends StatefulWidget {
  static final String id = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton(
            onPressed: () {
              AuthService.signOutUser(context);
            },
            color: Colors.red,
            child: const Text(
              "LogOut",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      )),
    );
  }
}
