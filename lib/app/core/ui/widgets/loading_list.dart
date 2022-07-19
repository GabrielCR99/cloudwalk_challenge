import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_shimmer.dart';

class LoadingList<B extends StateStreamable<S>, S> extends StatelessWidget {
  final B controller;
  final BlocWidgetSelector<S, bool> selector;
  final bool? visible;

  const LoadingList({
    required this.controller,
    required this.selector,
    this.visible,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<B, S, bool>(
      bloc: controller,
      selector: selector,
      builder: (_, loading) => Visibility(
        visible: loading,
        child: Expanded(
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (_, index) =>
                const CustomShimmer(height: 20, width: 10),
          ),
        ),
      ),
    );
  }
}
