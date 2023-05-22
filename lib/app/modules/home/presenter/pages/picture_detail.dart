import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../core/helpers/date_helper.dart';
import '../../domain/entities/picture_of_the_day_entity.dart';

class PictureDetail extends StatelessWidget {
  final PictureOfTheDayEntity picture;

  const PictureDetail({
    required this.picture,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(picture.title)),
      body: ListView(
        children: [
          FadeInImage.memoryNetwork(
            height: 260,
            width: double.infinity,
            placeholder: kTransparentImage,
            image: picture.url,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              DateHelper.formatDate(picture.date),
              style: textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              picture.explanation,
              textAlign: TextAlign.justify,
              style: textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
