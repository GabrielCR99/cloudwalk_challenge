import 'package:cloudwalk_challenge/app/core/shared/domain/failures/failure.dart';
import 'package:cloudwalk_challenge/app/modules/home/domain/entities/picture_of_the_day_entity.dart';
import 'package:cloudwalk_challenge/app/modules/home/domain/repositories/home_repository.dart';
import 'package:cloudwalk_challenge/app/modules/home/domain/usecases/fetch_pictures_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class HomeRepositoryMock extends Mock implements HomeRepository {}

void main() {
  late HomeRepository repository;
  late FetchPicturesUsecase usecase;
  const failure = Failure();

  setUp(() {
    repository = HomeRepositoryMock();
    usecase = FetchPicturesUsecase(repository: repository);
  });

  const pictures = <PictureOfTheDayEntity>[
    PictureOfTheDayEntity(
      date: '2022-07-19',
      title: 'Pleiades over Half Dome"',
      url:
          'https://apod.nasa.gov/apod/image/2207/HalfPleiades_Venkatraman_960.jpg',
      explanation: 'Stars come in bunches.'
          'The most famous bunch of stars on the sky is the Pleiades, a bright'
          'cluster that can be easily seen with the unaided eye.',
    ),
  ];

  test(
    'Should get a a List<PictureOfTheDayEntity> for a given limit from the repository',
    () async {
      when(() => repository(20)).thenAnswer((_) async => const Right(pictures));

      final result = await usecase(20);

      expect(result, const Right(pictures));
      verify(() => repository(20));
    },
  );

  test('Should return a Failure', () async {
    //Arrange
    when(() => repository(20)).thenAnswer((_) async => const Left(failure));

    //Act
    final result = await usecase(20);

    //Assert
    expect(result, const Left(failure));
    verify(() => repository(20));
  });
}
