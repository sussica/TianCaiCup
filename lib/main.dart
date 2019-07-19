import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui/flutter_firebase_ui.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AmIClose',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _HomePage(title: 'AmIClose'),
    );
  }
}

// Base Bottom NavigationBar App
class _HomePage extends StatefulWidget {
  _HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // current login user
  FirebaseUser _user;
  StreamSubscription<FirebaseUser> _subscription;

  var _selectedIndex = 0;

  static TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  // called before build view
  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  // todo map, friends page
  List<Widget> _buildFragmentsList() {
    return <Widget>[
      Text(
        'Map',
        style: optionStyle,
      ),
      Text(
        'Friends',
        style: optionStyle,
      ),
      (_user == null) ? _buildSignInFragment() : MeFragment(user: _user),
    ];
  }

  // fixme Unhandled Exception: Looking up a deactivated widget's ancestor is unsafe.
  // at package:firebase_ui/password_view.dart:116
  Widget _buildSignInFragment() {
    return new SignInScreen(
      header: new Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Text("Please Sign in first"),
        ),
      ),
      showBar: false,
      padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
      avoidBottomInset: true,
      color: Colors.white,
      providers: [
        //ProvidersTypes.google,
        ProvidersTypes.email
      ],
    );
  }

  // Build Bottom NavigationBar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AmIClose"),
      ),
      body: Center(child: _buildFragmentsList().elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Map'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('Friends'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Me'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  // Check current user in background
  void _checkCurrentUser() async {
    _user = await _auth.currentUser();
    _user?.getIdToken(refresh: true);
    // called when user sign in and sign out
    _subscription = _auth.onAuthStateChanged.listen((FirebaseUser user) {
      setState(() {
        _user = user;
      });
    });
  }
}

class MeFragment extends StatelessWidget {
  final FirebaseUser user;

  MeFragment({this.user});

  @override
  Widget build(BuildContext context) => new Scaffold(
      body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Hi,"),
              Text(user.displayName ?? user.email),
              RaisedButton(
                  color: Colors.blue,
                  child: new Text("Logout",),
                  onPressed: _logout)
            ],
          )));

  void _logout() {
    signOutProviders();
  }
}
