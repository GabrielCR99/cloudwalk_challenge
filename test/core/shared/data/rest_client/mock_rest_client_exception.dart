import 'package:cloudwalk_challenge/app/core/shared/data/rest_client/rest_client_exception.dart';
import 'package:cloudwalk_challenge/app/core/shared/data/rest_client/rest_client_response.dart';
import 'package:mocktail/mocktail.dart';

class MockRestClientException extends Mock implements RestClientException {
  @override
  final RestClientResponse? response;

  @override
  final int? statusCode;

  MockRestClientException({
    this.response,
    this.statusCode,
  });
}
