import 'dart:io';

import 'package:chat_app/widgets/Pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String username,
    File? image,
    bool isLogin,
    BuildContext context,
  ) submitFn;
  final bool isLoading;

  AuthForm(this.submitFn, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = "";
  var _userUsername = "";
  var _userPassword = "";
  File? _userImage;

  void _pickedImage(File image) {
    _userImage = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (_userImage == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please pick an image!",
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid!) {
      _formKey.currentState?.save();

      //send auth request to firebase
      widget.submitFn(
          _userEmail.trim(),_userPassword.trim(), _userUsername.trim(),_userImage, _isLogin, context);
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
                if (!_isLogin) UserImagePicker(_pickedImage),
                TextFormField(
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  enableSuggestions: false,
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
                    autocorrect: true,
                  textCapitalization: TextCapitalization.words,
                  enableSuggestions: false,
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
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text(
                      _isLogin ? "Login" : "Signup",
                    ),
                  ),
                if (!widget.isLoading)
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
