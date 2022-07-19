import 'package:dartz/dartz.dart';

import '../failures/failure.dart';

abstract class Usecase<Type, Parameters> {
  const Usecase();

  Either<Failure, Type> call(Parameters parameters);
}
