import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/shared/domain/failures/failure.dart';
import '../../domain/entities/picture_of_the_day_entity.dart';
import '../../domain/usecases/fetch_pictures_usecase.dart';

part 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final FetchPicturesUsecase _usecase;

  var _cachedPictures = const <PictureOfTheDayEntity>[];

  int get totalPictures => state.pictures.length;

  bool get hasMoreData =>
      totalPictures < 100 && state.status != HomeStatus.failure;

  HomeController({required FetchPicturesUsecase usecase})
      : _usecase = usecase,
        super(const HomeState.initial());

  void _emitLoadedState(
    Either<Failure, List<PictureOfTheDayEntity>> result, {
    bool withCache = true,
  }) =>
      emit(
        result.fold(
          (failure) => state.copyWith(status: HomeStatus.failure),
          (success) {
            if (withCache) {
              _cachedPictures = success;
            }

            return state.copyWith(
              status: HomeStatus.complete,
              pictures: success,
            );
          },
        ),
      );

  Future<void> loadPictures() async {
    emit(state.copyWith(status: HomeStatus.loading));

    final result = await _usecase(totalPictures);

    return _emitLoadedState(result);
  }

  Future<void> loadNextData() async {
    if (state.status != HomeStatus.loading) {
      emit(state.copyWith(status: HomeStatus.loading));

      final result = await _usecase(totalPictures + 10);

      return _emitLoadedState(result, withCache: false);
    }
  }

  void filterPictures(String searchText) {
    final foundPictures = _cachedPictures
        .where(
          (e) =>
              e.title.toLowerCase().contains(searchText.toLowerCase()) ||
              e.date.contains(searchText),
        )
        .toList();

    return emit(state.copyWith(pictures: foundPictures));
  }
}
