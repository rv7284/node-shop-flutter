import 'package:flutter/material.dart';
import 'package:node_shop/home_screen.dart';
import 'package:node_shop/login.dart';
import 'package:node_shop/user_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  final UserBloc userBloc = UserBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: userBloc.userToken,
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        String token = snapshot.data;
        if (token == null) {
          return Login(userBloc: userBloc);
        } else {
          saveToken(token);
          return HomeScreen(userBloc: userBloc);
        }
      },
    );
  }
}
