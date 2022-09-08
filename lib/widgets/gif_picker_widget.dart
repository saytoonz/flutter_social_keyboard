import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_social_keyboard/models/giphy_gif.dart';
import 'package:flutter_social_keyboard/models/keyboard_config.dart';
import 'package:flutter_social_keyboard/widgets/display/giphy_display.dart';

class GifPickerWidget extends StatefulWidget {
  final KeyboardConfig keyboardConfig;
  final Function(GiphyGif)? onGifSelected;

  final StreamController<String> scrollStream;

  const GifPickerWidget({
    Key? key,
    required this.keyboardConfig,
    required this.scrollStream,
    this.onGifSelected,
  }) : super(key: key);

  @override
  State<GifPickerWidget> createState() => _GifPickerWidgetState();
}

class _GifPickerWidgetState extends State<GifPickerWidget>
    with SingleTickerProviderStateMixin {
  PageController? _pageController;
  TabController? _tabController;
  final double tabBarHeight = 46;
  final int initCategory = 0;

  late final List<String> _tabs = [
    '',
    'Trending',
    ...widget.keyboardConfig.gifTabs
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
        initialIndex: initCategory, length: _tabs.length, vsync: this)
      ..addListener(() => widget.scrollStream.add('showNav'));

    _pageController = PageController(initialPage: initCategory)
      ..addListener((() => widget.scrollStream.add('showNav')));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: widget.keyboardConfig.bgColor,
      child: Column(
        children: [
          SizedBox(
            height: tabBarHeight,
            child: TabBar(
              isScrollable: _tabs.length > 4,
              labelColor: widget.keyboardConfig.iconColorSelected,
              indicatorColor: widget.keyboardConfig.indicatorColor,
              unselectedLabelColor: widget.keyboardConfig.iconColor,
              controller: _tabController,
              labelPadding: _tabs.length > 4
                  ? const EdgeInsets.symmetric(horizontal: 10)
                  : EdgeInsets.zero,
              onTap: (index) {
                _pageController!.jumpToPage(index);
              },
              tabs: _tabs
                  .asMap()
                  .entries
                  .map((item) => _buildCategory(item.key, item.value))
                  .toList(),
            ),
          ),
          (widget.keyboardConfig.giphyAPIKey ?? "").isEmpty
              ? const Text("No GIPHY API Key Found")
              : Flexible(
                  child: PageView.builder(
                    itemCount: _tabs.length,
                    controller: _pageController,
                    onPageChanged: (index) {
                      _tabController!.animateTo(
                        index,
                        duration:
                            widget.keyboardConfig.tabIndicatorAnimDuration,
                      );
                    },
                    itemBuilder: (context, index) => GiphyDisplay(
                      searchKeyword: _tabs[index],
                      keyboardConfig: widget.keyboardConfig,
                      onGifSelected: widget.onGifSelected,
                      scrollStream: widget.scrollStream,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildCategory(int index, String title) {
    return Tab(
      child: index == 0
          ? const Icon(Icons.access_time)
          : Text(
              title.toUpperCase(),
            ),
    );
  }
}
