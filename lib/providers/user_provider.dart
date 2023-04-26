import 'package:flutter/cupertino.dart';
import 'package:greenify_new/utilities/authcontroller.dart';
import 'package:greenify_new/utilities/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthController _auth = AuthController();

  Future<void> refreshUser() async {
    User user = await _auth.getUserDetails();
    _user = user;
    notifyListeners();
  }

  User get getUser => _user!;
}
