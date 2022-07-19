import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/shared/domain/failures/failure.dart';
import '../../../domain/entities/picture_of_the_day_entity.dart';
import '../../models/picture_of_the_day_model.dart';
import 'home_datasource_decorator.dart';

class HomeLocalDatasourceDecoratorImpl extends HomeDatasourceDecorator {
  HomeLocalDatasourceDecoratorImpl({required super.homeDatasource});

  @override
  Future<Either<Failure, List<PictureOfTheDayEntity>>> call(int limit) async {
    return (await super(limit)).fold(
      (failure) async => Right(await _readLocalPictures()),
      (pictures) async {
        await _saveLocalPictures(pictures);

        return Right(pictures);
      },
    );
  }

  Future<List<PictureOfTheDayEntity>> _readLocalPictures() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('pictures')!;
    final json = jsonDecode(data) as List<dynamic>;

    return json
        .cast<Map<String, dynamic>>()
        .map(PictureOfTheDayModel.fromJson)
        .toList();
  }

  Future<void> _saveLocalPictures(List<PictureOfTheDayEntity> pictures) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonPictures =
        jsonEncode(pictures.map((picture) => picture.toJson()).toList());
    await prefs.setString('pictures', jsonPictures);
  }
}
