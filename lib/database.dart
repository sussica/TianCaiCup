library firebase_wrapper;
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';

/// Data Structure:
/// Users {
/// [
///   <id>:{
///     name: <name>
///     position: <latitude>#<longitude>,
///     friends: [<id1>, <id2>]
///   }
/// ]
///
class FirebaseWrapper {
  static const userKey = "users";
  var _id;
  static const nameKey = "name";
  static const positionKey = "position";
  static const friendKey = "friends";

  User me;

  DatabaseReference _rootReference;
  DatabaseReference _me;
  DatabaseReference _myFriends;

  static FirebaseWrapper _firebase;

  FirebaseWrapper._private(FirebaseUser user) {
    _rootReference = FirebaseDatabase.instance.reference().child(userKey);
    _id = user.uid;
    _me = _rootReference.child(_id);
    _myFriends = _me.child(friendKey);
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
  String _id;
  String _name;
  SimplePosition position;

  String get id => _id;

  String get name => _name;

  User(String name, SimplePosition position, {String id = ""}) {
    this._name = name;
    this.position = position;
    this._id = id;
  }
}

/// Rename to SimplePosition to avoid duplicate with Position in geolocator.dart
class SimplePosition {
  // default 50 meter
  int closeDistance = 50;
  double latitude;
  double longitude;

  SimplePosition(this.latitude, this.longitude);

  /// return true when distance no greater than closeDistance
  Future<bool> isClose2(SimplePosition other) async {
    return Geolocator().distanceBetween(this.latitude, this.longitude, other.latitude, other.longitude).then((double distance) {
      print("distance: $distance");
      return distance <= closeDistance;
    });
  }

  static SimplePosition decode(String s) {
    try {
      List<String> pos = s.split("#");
      return SimplePosition(double.parse(pos[0]), double.parse(pos[1]));
    } on Exception {
      return null;
    }
  }

  /// encode position to format: latitude#longitude
  static String encode(SimplePosition position) {
    return '${position.latitude}#${position.longitude}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SimplePosition &&
              runtimeType == other.runtimeType &&
              latitude == other.latitude &&
              longitude == other.longitude;

  @override
  int get hashCode =>
      latitude.hashCode ^
      longitude.hashCode;

  @override
  String toString() {
    return '$latitude#$longitude';
  }
}
