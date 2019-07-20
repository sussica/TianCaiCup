library firebase_wrapper;

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseWrapper {

  final _userKey = "users";
  var _id;
  var _friendKey = "friends";

  User me;

  DatabaseReference _rootReference;
  DatabaseReference _me;
  DatabaseReference _myFriends;

  static FirebaseWrapper _firebase;

  FirebaseWrapper._private(FirebaseUser user) {
    _rootReference = FirebaseDatabase.instance.reference().child(_userKey);
    _id = user.getIdToken();
    _me = _rootReference.child(_id);
    _myFriends = _me.child(_friendKey);
    // TODO: set me
    me;
  }

  static FirebaseWrapper getInstance(FirebaseUser user) {
    if (_firebase == null) {
      _firebase = new FirebaseWrapper._private(user);
    }
    return _firebase;
  }

  List<User> getFriends() {
    // TODO: return friends using _myFriends
    return null;
  }

  void addFriendWithId(String id) {
    // TODO: get User with the given id
    User user;
    addFriend(user);
  }

  void addFriend(User user) {

  }

  void onPositionChange(Function() func) {
    // TODO: register this function to when _myFriends observes a change.
  }

  List<User> getFriendsWithin(double distance) {
    // Return list of friends close to us
    return null;
  }

}

class User {
  String id;
  String name;
  Position position;

  User(String name, Position position, {String id = ""}) {
      this.name = name;
      this.position = position;
      this.id = id;
  }

}

class Position {
  double xCoordinate;
  double yCoordinate;

  Position(double xCoordinate, double yCoordinate) {
    this.xCoordinate = xCoordinate;
    this.yCoordinate = yCoordinate;
  }

}