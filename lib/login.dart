import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 100.0),
            TextField(
              decoration: InputDecoration(
                  hasFloatingPlaceholder: true, hintText: 'Email'),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                  hasFloatingPlaceholder: true, hintText: 'Password'),
            ),
            SizedBox(height: 100.0),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
