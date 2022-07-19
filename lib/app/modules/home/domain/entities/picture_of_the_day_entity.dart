import 'package:equatable/equatable.dart';

class PictureOfTheDayEntity extends Equatable {
  final String date;
  final String explanation;
  final String url;
  final String title;

  const PictureOfTheDayEntity({
    required this.date,
    required this.explanation,
    required this.url,
    required this.title,
  });

  @override
  List<Object> get props => [date, explanation, url, title];
}
