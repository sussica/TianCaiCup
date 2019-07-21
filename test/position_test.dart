import 'package:flutter_test/flutter_test.dart';

import 'package:tian_cai_cup/database.dart';

import 'package:geolocator/geolocator.dart';

void main() {

  test("Test SimplePosition decode encode", (){
    SimplePosition position = SimplePosition(20, 80);
    print(SimplePosition.decode(position.toString()));
    expect(true, position == SimplePosition.decode(position.toString()));
  });
}