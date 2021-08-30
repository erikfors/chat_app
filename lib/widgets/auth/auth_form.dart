import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext context,
  ) submitFn;

  AuthForm(this.submitFn);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = "";
  var _userUsername = "";
  var _userPassword = "";

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid!) {
      _formKey.currentState?.save();

      //send auth request to firebase
      widget.submitFn(_userEmail, _userPassword, _userUsername, _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: ValueKey(
                    "email",
                  ),
                  onSaved: (value) {
                    _userEmail = value!;
                  },
                  validator: (value) {
                    if (value == null) {
                      return "";
                    }
                    if (value.isEmpty || !value.contains("@")) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email Address",
                  ),
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey(
                      "username",
                    ),
                    onSaved: (value) {
                      _userUsername = value!;
                    },
                    validator: (value) {
                      if (value == null) {
                        return "";
                      }
                      if (value.isEmpty || value.length < 4) {
                        return "Enter at least 4 charactrs";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Username",
                    ),
                  ),
                TextFormField(
                  key: ValueKey(
                    "password",
                  ),
                  onSaved: (value) {
                    _userPassword = value!;
                  },
                  validator: (value) {
                    if (value == null) {
                      return "";
                    }
                    if (value.isEmpty || value.length < 7) {
                      return "Enter at least 7 charactrs";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: _trySubmit,
                  child: Text(
                    _isLogin ? "Login" : "Signup",
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(
                    _isLogin
                        ? "Create new account"
                        : "I already have an account",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
