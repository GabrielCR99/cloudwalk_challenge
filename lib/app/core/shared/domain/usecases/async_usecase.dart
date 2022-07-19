import 'package:dartz/dartz.dart';

import '../failures/failure.dart';

abstract class AsyncUsecase<Type, Parameters> {
  const AsyncUsecase();

  Future<Either<Failure, Type>> call(Parameters parameters);
}
