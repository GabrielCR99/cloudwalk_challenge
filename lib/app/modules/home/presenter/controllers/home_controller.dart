import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/shared/domain/failures/failure.dart';
import '../../domain/entities/picture_of_the_day_entity.dart';
import '../../domain/usecases/fetch_pictures_usecase.dart';

part 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final FetchPicturesUsecase _usecase;

  var pictures = const <PictureOfTheDayEntity>[];
  List<PictureOfTheDayEntity>? _cachedPictures;

  int get totalPictures => pictures.length;

  bool get hasMoreData =>
      totalPictures < 100 && state.status != HomeStatus.failure;

  HomeController({required FetchPicturesUsecase usecase})
      : _usecase = usecase,
        super(const HomeState.initial());

  void _emitLoadingState() => emit(
        state.copyWith(
          status: HomeStatus.loading,
          pictures: const <PictureOfTheDayEntity>[],
        ),
      );

  void _emitLoadedState(
    Either<Failure, List<PictureOfTheDayEntity>> result, {
    bool withCache = true,
  }) =>
      emit(
        result.fold(
          (failure) => state.copyWith(status: HomeStatus.failure),
          (success) {
            pictures = success;
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
    _emitLoadingState();

    final result = await _usecase(totalPictures);
    _emitLoadedState(result);
  }

  Future<void> loadNextData() async {
    if (state.status != HomeStatus.loading) {
      _emitLoadingState();

      final result = await _usecase(totalPictures + 10);

      _emitLoadedState(result, withCache: false);
    }
  }

  void filterPictures(String searchText) {
    final foundPictures = _cachedPictures!
        .where(
          (e) =>
              e.title.toLowerCase().contains(searchText.toLowerCase()) ||
              e.date.contains(searchText),
        )
        .toList();

    emit(state.copyWith(pictures: foundPictures));
  }
}
