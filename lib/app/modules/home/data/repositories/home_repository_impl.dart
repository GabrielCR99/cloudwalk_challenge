import 'package:dartz/dartz.dart';

import '../../domain/entities/picture_of_the_day_entity.dart';
import '../../../../core/shared/domain/failures/failure.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource _datasource;

  const HomeRepositoryImpl({required HomeDatasource datasource})
      : _datasource = datasource;

  @override
  Future<Either<Failure, List<PictureOfTheDayEntity>>> call(int limit) async =>
      _datasource(limit);
}
