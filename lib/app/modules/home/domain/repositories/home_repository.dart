import 'package:dartz/dartz.dart';

import '../../../../core/shared/domain/failures/failure.dart';
import '../entities/picture_of_the_day_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<PictureOfTheDayEntity>>> call(int limit);
}
