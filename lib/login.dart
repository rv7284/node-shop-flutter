import 'package:flutter/material.dart';
import 'package:node_shop/register.dart';
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

  FocusNode _passwordNode = FocusNode();

  _loginUser() {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty) {
    } else if (password.isEmpty) {
    } else {
      UserCredentials credentials = UserCredentials(email, password);
      widget.userBloc.userLogin.add(credentials);
    }
  }

  @override
  Widget build(BuildContext context) {
    // userBloc.userAuth.add(UserCredentials(email, password))
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome To Shop'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 100.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  hasFloatingPlaceholder: true, hintText: 'Email'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              onSubmitted: (value) {
                FocusScope.of(context).requestFocus(_passwordNode);
              },
            ),
            SizedBox(height: 20.0),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                  hasFloatingPlaceholder: true, hintText: 'Password'),
              focusNode: _passwordNode,
              onSubmitted: (value) {
                _loginUser();
              },
            ),
            SizedBox(height: 100.0),
            StreamBuilder<bool>(
              initialData: false,
              stream: widget.userBloc.isLoading,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.data) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return RaisedButton(
                    color: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 12.0),
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    onPressed: _loginUser,
                  );
                }
              },
            ),
            SizedBox(height: 20.0),
            Container(
              width: double.maxFinite,
              height: 44.0,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    right: 0.0,
                    child: FlatButton(
                      child: Text(
                        'Create an account',
                        style: TextStyle(fontSize: 17.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Register(userBloc: widget.userBloc)));
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
