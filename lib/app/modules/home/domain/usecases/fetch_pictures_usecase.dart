import 'package:dartz/dartz.dart';

import '../../../../core/shared/domain/failures/failure.dart';
import '../../../../core/shared/domain/usecases/async_usecase.dart';
import '../entities/picture_of_the_day_entity.dart';
import '../repositories/home_repository.dart';

class FetchPicturesUsecase
    implements AsyncUsecase<List<PictureOfTheDayEntity>, int> {
  final HomeRepository _repository;

  const FetchPicturesUsecase({required HomeRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<PictureOfTheDayEntity>>> call(int limit) async {
    if (limit == 0) {
      limit = 20;
    }

    return await _repository(limit);
  }
}
