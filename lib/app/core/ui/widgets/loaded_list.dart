import 'package:flutter/material.dart';

class LoadedList extends StatefulWidget {
  final VoidCallback onLoadNextData;
  final VoidCallback onRefresh;
  final bool hasMoreData;
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;

  const LoadedList({
    required this.onLoadNextData,
    required this.onRefresh,
    required this.itemBuilder,
    required this.itemCount,
    required this.hasMoreData,
    super.key,
  });

  @override
  State<LoadedList> createState() => _LoadedListState();
}

class _LoadedListState extends State<LoadedList> {
  final _scrollController = ScrollController();
  var busy = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final currentScroll = _scrollController.position;
    final maxScroll = _scrollController.position.maxScrollExtent * 0.6;

    if (!busy && currentScroll.pixels > maxScroll && widget.hasMoreData) {
      busy = true;
      widget.onLoadNextData();
      busy = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => widget.onRefresh(),
            child: ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.itemCount,
              itemBuilder: widget.itemBuilder,
            ),
          ),
        ),
      ],
    );
  }
}
