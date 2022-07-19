import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/helpers/date_helper.dart';
import '../../domain/entities/picture_of_the_day_entity.dart';
import '../pages/picture_detail.dart';

class PictureTile extends StatelessWidget {
  final PictureOfTheDayEntity picture;

  const PictureTile({required this.picture, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Modular.to.push(
        MaterialPageRoute(builder: (_) => PictureDetail(picture: picture)),
      ),
      title: Text(picture.title),
      subtitle: Text(DateHelper.formatDate(picture.date)),
    );
  }
}
