import 'package:cloudwalk_challenge/app/core/shared/domain/failures/failure.dart';
import 'package:cloudwalk_challenge/app/modules/home/data/datasources/home_datasource.dart';
import 'package:cloudwalk_challenge/app/modules/home/data/repositories/home_repository_impl.dart';
import 'package:cloudwalk_challenge/app/modules/home/domain/entities/picture_of_the_day_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class HomeDatasourceMock extends Mock implements HomeDatasource {}

void main() {
  late HomeRepositoryImpl repository;
  late HomeDatasource datasource;

  setUp(() {
    datasource = HomeDatasourceMock();
    repository = HomeRepositoryImpl(datasource: datasource);
  });

  const pictures = <PictureOfTheDayEntity>[
    PictureOfTheDayEntity(
      date: '2022-07-19',
      title: 'Pleiades over Half Dome',
      url:
          'https://apod.nasa.gov/apod/image/2207/HalfPleiades_Venkatraman_960.jpg',
      explanation: 'Stars come in bunches.'
          'The most famous bunch of stars on the sky is the Pleiades, a bright'
          'cluster that can be easily seen with the unaided eye.',
    ),
  ];

  test(
    'Should return a List<PictureOfTheDayModel> when HomeDatasource is called',
    () async {
      when(() => datasource(20)).thenAnswer((_) async => const Right(pictures));

      final result = await repository(20);

      expect(result, const Right(pictures));
      verify(() => datasource(20));
    },
  );

  test('Should return a Failure', () async {
    //Arrange
    const failure = Failure();
    when(() => datasource(20)).thenAnswer((_) async => const Left(failure));

    //Act
    final result = await repository(20);

    //Assert
    expect(result, const Left(failure));
    verify(() => datasource(20));
  });
}
