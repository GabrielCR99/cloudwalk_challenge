import '../../domain/entities/picture_of_the_day_entity.dart';

extension PictureOfTheDayModel on PictureOfTheDayEntity {
  static PictureOfTheDayEntity fromJson(Map<String, dynamic> json) =>
      PictureOfTheDayEntity(
        date: json['date'] ?? '',
        explanation: json['explanation'] ?? '',
        url: json['url'] ?? '',
        title: json['title'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'date': date,
        'explanation': explanation,
        'url': url,
        'title': title,
      };
}
