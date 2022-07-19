import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'fixture_reader.dart';

void main() {
  test('Should return a json', () async {
    final json =
        FixtureReader.getJsonData('core/fixture/fixture_reader_test.json');

    expect(
      json,
      allOf([
        isNotNull,
        isNotEmpty,
      ]),
    );
  });

  test('Should return Map<String, dynamic>', () async {
    //Arrange

    //Act
    final data = FixtureReader.getData<Map<String, dynamic>>(
      'core/fixture/fixture_reader_test.json',
    );

    //Assert

    expect(
      data,
      allOf([
        isNotNull,
        isA<Map<String, dynamic>>(),
      ]),
    );

    expect(data['id'], 1);
  });

  test('Should return List', () async {
    //Arrange

    //Act
    final data = FixtureReader.getData<List>(
      'core/fixture/fixture_reader_list_test.json',
    );

    expect(data, isA<List>());
    expect(data.isNotEmpty, isTrue);
    expect(data, isNotEmpty);
    expect(data.length, 2);
    expect(data.first['id'], 1);
  });

  test('Should return FileSystemException if File is not found', () async {
    //Arrange

    //Act
    var call = FixtureReader.getData;

    //Assert
    expect(() => call('error.json'), throwsA(isA<FileSystemException>()));
  });
}
