import 'package:dartz/dartz.dart';

import '../../../../../core/shared/domain/failures/failure.dart';
import '../../../domain/entities/picture_of_the_day_entity.dart';
import '../home_datasource.dart';

class HomeDatasourceDecorator implements HomeDatasource {
  final HomeDatasource _homeDatasource;

  HomeDatasourceDecorator({required HomeDatasource homeDatasource})
      : _homeDatasource = homeDatasource;

  @override
  Future<Either<Failure, List<PictureOfTheDayEntity>>> call(int limit) =>
      _homeDatasource(limit);
}
