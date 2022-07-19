part of 'home_controller.dart';

enum HomeStatus {
  inital,
  loading,
  complete,
  failure;
}

class HomeState extends Equatable {
  final List<PictureOfTheDayEntity> pictures;
  final HomeStatus status;

  const HomeState._({
    required this.pictures,
    required this.status,
  });

  const HomeState.initial()
      : this._(
          pictures: const <PictureOfTheDayEntity>[],
          status: HomeStatus.inital,
        );

  @override
  List<Object?> get props => [pictures, status];

  HomeState copyWith({
    List<PictureOfTheDayEntity>? pictures,
    HomeStatus? status,
  }) {
    return HomeState._(
      pictures: pictures ?? this.pictures,
      status: status ?? this.status,
    );
  }
}
