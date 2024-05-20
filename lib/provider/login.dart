import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier {
  String? emailValidationError;
  String? passwordValidationError;

  String? validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{5,}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      passwordValidationError =
      'Password must contain at least 1 uppercase letter, 1 lowercase letter, 1 number, and be at least 5 characters long';
    } else {
      passwordValidationError = null;
    }
    notifyListeners();
    return passwordValidationError;
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    if (value!.isEmpty || !regex.hasMatch(value)) {
      emailValidationError = 'Enter a valid email address';
    } else {
      emailValidationError = null;
    }
    notifyListeners();
    return emailValidationError;
  }
  bool isLoginButtonEnabled() {
    return emailValidationError == null && passwordValidationError == null;
  }
}


class LoginProviderSecond extends ChangeNotifier {
  String? emailValidationError;
  String? passwordValidationError;

  String? validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{5,}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      passwordValidationError =
      'Password must contain at least 1 uppercase letter, 1 lowercase letter, 1 number, and be at least 5 characters long';
    } else {
      passwordValidationError = null;
    }
    notifyListeners();
    return passwordValidationError;
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    if (value!.isEmpty || !regex.hasMatch(value)) {
      emailValidationError = 'Enter a valid email address';
    } else {
      emailValidationError = null;
    }
    notifyListeners();
    return emailValidationError;
  }
  bool isLoginButtonEnabled() {
    return emailValidationError == null && passwordValidationError == null;
  }
}