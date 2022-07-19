import 'package:dio/dio.dart';

import '../shared/data/rest_client/rest_client_exception.dart';
import '../shared/data/rest_client/rest_client_response.dart';

class RestClientHelper {
  const RestClientHelper._();

  static const _connectionError =
      'Não foi possível obter informações da aplicação. Favor verificar a conexão e tentar novamente.';
  static const _unexpectedError = 'Ocorreu um erro inesperado';

  static RestClientException getRestClientException(DioError dioError) {
    try {
      final response = dioError.response;
      final statusCode = response?.statusCode;
      final statusMessage = response?.statusMessage;
      final data = response?.data;

      if (dioError.type != DioErrorType.response) {
        return RestClientException(
          statusCode: statusCode,
          message: _connectionError,
          response: RestClientResponse(
            data: data,
            statusCode: statusCode,
            statusMessage: statusMessage,
          ),
        );
      }

      return RestClientException(
        statusCode: statusCode,
        message: data! != '' ? data!['message'] : _connectionError,
        response: RestClientResponse(
          data: data,
          statusCode: statusCode,
          statusMessage: statusMessage,
        ),
      );
    } catch (_) {
      return const RestClientException(message: _unexpectedError);
    }
  }
}
