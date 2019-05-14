import 'package:flutter/material.dart';
import 'package:node_shop/user_bloc.dart';

class HomeScreen extends StatelessWidget {
  final UserBloc userBloc;

  const HomeScreen({@required this.userBloc});

  void _logoutUser(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to Logout?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                userBloc.logoutUser();
              },
            ),
            FlatButton(
              child: Text("Cancle"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _logoutUser(context);
            },
          )
        ],
      ),
      body: Center(
        child: Text('Login'),
      ),
    );
  }
}
