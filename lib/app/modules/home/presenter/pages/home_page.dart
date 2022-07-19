import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/ui/widgets/loaded_list.dart';
import '../../../../core/ui/widgets/loading_list.dart';
import '../../domain/entities/picture_of_the_day_entity.dart';
import '../controllers/home_controller.dart';
import '../widgets/picture_tile.dart';
import '../widgets/search_picture_text_field.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final _controller = Modular.get<HomeController>()..loadPictures();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Column(
        children: [
          SearchPictureTextField(onChanged: _controller.filterPictures),
          LoadingList<HomeController, HomeState>(
            controller: _controller,
            selector: (state) => state.status == HomeStatus.loading,
          ),
          BlocSelector<HomeController, HomeState, List<PictureOfTheDayEntity>>(
            bloc: _controller,
            selector: (state) => state.pictures,
            builder: (_, pictures) => Visibility(
              visible: pictures.isNotEmpty,
              child: LoadedList(
                itemCount: pictures.length,
                hasMoreData: _controller.hasMoreData,
                itemBuilder: (_, index) =>
                    PictureTile(picture: pictures[index]),
                onLoadNextData: _controller.loadNextData,
                onRefresh: _controller.loadPictures,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
