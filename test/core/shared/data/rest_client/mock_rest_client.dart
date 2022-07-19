import 'package:cloudwalk_challenge/app/core/shared/data/rest_client/dio/dio_rest_client.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_response.dart';
import 'mock_rest_client_exception.dart';

class MockRestClient extends Mock implements DioRestClient {
  MockRestClient();

  void mockGet<T>({required MockResponse<T> response}) =>
      when(() => get<T>(any())).thenAnswer((_) async => response);

  void mockGetException<T>({MockRestClientException? mockException}) {
    final exception = _mockException(mockException);

    when(() => get<T>(any())).thenThrow(exception);
  }

  MockRestClientException _mockException(
    MockRestClientException? mockException,
  ) {
    var exception = mockException;
    if (exception == null) {
      exception = MockRestClientException();
      when(() => exception!.message).thenReturn('Dio Error');
    }

    return exception;
  }
}
