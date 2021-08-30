import 'package:chat_app/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return FutureBuilder(
      builder: (ctx, appSnapshot) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.pink,
            backgroundColor: Colors.pink,
            accentColor: Colors.deepPurple,
            accentColorBrightness: Brightness.dark,
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.pink,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
            ),
          ),
          home: appSnapshot.connectionState != ConnectionState.done
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : StreamBuilder(
                  builder: (ctx, userSnapshot) {
                    if (userSnapshot.hasData) {
                      return ChatScreen();
                    }
                    return AuthScreen();
                  },
                  stream: FirebaseAuth.instance.authStateChanges(),
                ),
        );
      },
      future: _initialization,
    );
  }
}
