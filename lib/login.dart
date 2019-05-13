import 'package:flutter/material.dart';
import 'package:node_shop/user_bloc.dart';

class Login extends StatefulWidget {
  final UserBloc userBloc;
  Login({@required this.userBloc});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // userBloc.userAuth.add(UserCredentials(email, password))
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
              controller: _emailController,
              decoration: InputDecoration(
                  hasFloatingPlaceholder: true, hintText: 'Email'),
            ),
            SizedBox(height: 20.0),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                  hasFloatingPlaceholder: true, hintText: 'Password'),
            ),
            SizedBox(height: 100.0),
            StreamBuilder<bool>(
              initialData: false,
              stream: widget.userBloc.isLoading,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.data) {
                  return CircularProgressIndicator();
                } else {
                  return RaisedButton(
                    color: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 12.0),
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    onPressed: () {
                      String email = _emailController.text;
                      String password = _passwordController.text;

                      if (email.isNotEmpty && password.isNotEmpty) {
                        UserCredentials credentials =
                            UserCredentials(email, password);
                        widget.userBloc.userAuth.add(credentials);
                      }
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
