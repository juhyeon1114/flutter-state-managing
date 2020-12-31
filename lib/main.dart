import 'dart:async';
import 'package:flutter/material.dart';

final authRepository = AuthRepository();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RootPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('LoginPage')),
      body: Center(
        child: RaisedButton(
          child: Text('login'),
          onPressed: () {authRepository.setAuthState(AuthState.Authenticated);},
        )
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MainPage')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Main Page'),
            RaisedButton(
              child: Text('logout'),
              onPressed: () {authRepository.setAuthState(AuthState.UnAuthenticated);},
            )
          ],
        ),
      ),
    );
  }
}

enum AuthState { Authenticated, UnAuthenticated }

class AuthRepository {
  final _streamController = StreamController<AuthState>()..add(AuthState.UnAuthenticated);

  get authStream => _streamController.stream;

  void setAuthState(AuthState state) {
    _streamController.add(state);
  }
}

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: authRepository.authStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == AuthState.UnAuthenticated) {
          return LoginPage();
        }
        return MainPage();
      }
    );
  }
}



