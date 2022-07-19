import 'rest_client_response.dart';

class RestClientException implements Exception {
  final int? statusCode;
  final String? message;
  final RestClientResponse? response;

  const RestClientException({
    this.response,
    this.statusCode,
    this.message,
  });
}
