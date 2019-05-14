import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:node_shop/user_bloc.dart';
import 'package:node_shop/utils/helper.dart';

class Register extends StatefulWidget {
  final UserBloc userBloc;

  Register({@required this.userBloc});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _emailNode = FocusNode();

  final FocusNode _passwordNode = FocusNode();

  final FocusNode _confirmPasswordNode = FocusNode();

  _registerUser(BuildContext context) {
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (email.isEmpty) {
      _emailNode.unfocus();
      _passwordNode.unfocus();
      _confirmPasswordNode.unfocus();
      showToast("Enter email");
    } else if (password.isEmpty) {
      showToast("Enter password");
    } else if (password.isEmpty) {
      showToast("Enter confirm password");
    } else if (password != confirmPassword) {
      showToast("Password doesn't match");
    } else if (password.length > 20) {
      showToast("wooah... Too long!!! \n make it under 20",
          length: Toast.LENGTH_LONG);
    } else {
      UserCredentials credentials = UserCredentials(email, password);
      widget.userBloc.userRegister.add(credentials);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
              focusNode: _emailNode,
              autocorrect: false,
            ),
            SizedBox(height: 20.0),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                  hasFloatingPlaceholder: true, hintText: 'Password'),
              focusNode: _passwordNode,
              textInputAction: TextInputAction.next,
              onSubmitted: (value) {
                _passwordNode.unfocus();
                FocusScope.of(context).requestFocus(_confirmPasswordNode);
              },
            ),
            SizedBox(height: 20.0),
            TextField(
              obscureText: true,
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                  hasFloatingPlaceholder: true, hintText: 'Confirm Password'),
              focusNode: _confirmPasswordNode,
              onSubmitted: (value) {
                _registerUser(context);
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
                      'Register',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    onPressed: () {
                      _registerUser(context);
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
