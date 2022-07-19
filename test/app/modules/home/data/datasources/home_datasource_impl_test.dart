import 'dart:convert';
import 'dart:io';

import 'package:cloudwalk_challenge/app/core/shared/domain/failures/failure.dart';
import 'package:cloudwalk_challenge/app/modules/home/data/datasources/home_datasource.dart';
import 'package:cloudwalk_challenge/app/modules/home/data/datasources/remote/home_remote_datasource_impl.dart';
import 'package:cloudwalk_challenge/app/modules/home/domain/entities/picture_of_the_day_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../core/fixture/fixture_reader.dart';
import '../../../../../core/shared/data/rest_client/mock_response.dart';
import '../../../../../core/shared/data/rest_client/mock_rest_client.dart';
import '../../../../../core/shared/data/rest_client/mock_rest_client_exception.dart';

Future<void> main() async {
  late MockRestClient restClient;
  late HomeDatasource datasource;
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  setUp(() {
    restClient = MockRestClient();
    datasource = HomeRemoteDatasourceImpl(restClient: restClient);
  });

  test('Should call get method with the given url ', () async {
    final jsonData = FixtureReader.getJsonData(
      'app/modules/home/data/fixtures/picture_of_the_day_success_fixture.json',
    );

    final responseData = jsonDecode(jsonData) as List<dynamic>;

    final response =
        MockResponse(data: responseData, statusCode: HttpStatus.ok);

    restClient.mockGet<List<dynamic>>(response: response);

    final result = await datasource(20);

    expect(result, isA<Right>());
  });

  test('should throw a Failure when the call is unccessful', () async {
    // Arrange
    final exception = MockRestClientException();

    when(() => exception.message).thenReturn('Ocorreu um erro');

    restClient.mockGetException<List<dynamic>>(mockException: exception);
    // Act
    final result = await datasource(1);
    // Assert
    expect(result, isA<Left<Failure, List<PictureOfTheDayEntity>>>());
  });
}
