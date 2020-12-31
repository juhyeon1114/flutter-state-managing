import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthState { Authenticated, UnAuthenticated }

class AuthRepository with ChangeNotifier {
  AuthState authState = AuthState.UnAuthenticated;

  void setState(AuthState state) {
    authState = state;
    notifyListeners();
  }
}

void main() => runApp(
  MultiProvider(
    child: MyApp(),
    providers: [
      ChangeNotifierProvider.value(value: AuthRepository())
    ],
  )
);

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
          onPressed: () {
            Provider.of<AuthRepository>(context, listen: false).setState(AuthState.Authenticated);
          },
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
              onPressed: () {
                Provider.of<AuthRepository>(context, listen: false).setState(AuthState.UnAuthenticated);
              },
            )
          ],
        ),
      ),
    );
  }
}

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthState authState = Provider.of<AuthRepository>(context).authState;
    return authState == AuthState.UnAuthenticated ? LoginPage() : MainPage();
  }
}



