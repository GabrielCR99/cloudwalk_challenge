import 'package:dartz/dartz.dart';

import '../../../../../core/helpers/environments.dart';
import '../../../../../core/shared/data/rest_client/rest_client.dart';
import '../../../../../core/shared/data/rest_client/rest_client_exception.dart';
import '../../../../../core/shared/domain/failures/failure.dart';
import '../../../domain/entities/picture_of_the_day_entity.dart';
import '../../models/picture_of_the_day_model.dart';
import '../home_datasource.dart';

class HomeRemoteDatasourceImpl implements HomeDatasource {
  final RestClient _restClient;

  const HomeRemoteDatasourceImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<Either<Failure, List<PictureOfTheDayEntity>>> call(int limit) async {
    try {
      final response = await _restClient.get<List<dynamic>>(
        '/planetary/apod?api_key=${Environments.params('nasa_api_key')}&count=$limit',
      );

      return Right(
        response.data!
            .cast<Map<String, dynamic>>()
            .map(PictureOfTheDayModel.fromJson)
            .toList(),
      );
    } on RestClientException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
