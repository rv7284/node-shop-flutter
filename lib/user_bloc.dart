import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCredentials {
  final String email;
  final String password;

  dynamic json() {
    return {
      'email': email,
      'password': password,
    };
  }

  UserCredentials(this.email, this.password);
}

class UserBloc {
  Stream<String> get userToken => _loginStatusSubject.stream;
  final _loginStatusSubject = BehaviorSubject<String>();

  Sink<UserCredentials> get userAuth => _userController.sink;
  final _userController = StreamController<UserCredentials>();

  void close() {
    _userController.close();
  }

  static const _baseUrl = 'https://rv7284-node-shop-api.herokuapp.com';

  UserBloc() {
    _initUser();
  }

  _initUser() async {
    SharedPreferences.getInstance().then((prefs) {
      String token = prefs.getString('token');
      if (token != null) {
        _loginStatusSubject.sink.add(token);
      }
    });

    _userController.stream.listen((userCredentials) async {
      var response = await http.post(_baseUrl + '/user/login',
          body: userCredentials.json());
      var jsonResponse = convert.jsonDecode(response.body);
      String token = jsonResponse['token'];
      _loginStatusSubject.sink.add(token);
    });
  }
}
