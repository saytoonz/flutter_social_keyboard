import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_social_keyboard/models/keyboard_config.dart';
import 'package:flutter_social_keyboard/models/sticker_model.dart';
import 'package:flutter_social_keyboard/widgets/sticker_display.dart';

class StickerPickerWidget extends StatefulWidget {
  const StickerPickerWidget({
    Key? key,
    required this.keyboardConfig,
    this.onStickerSelected,
    required this.scrollStream,
  }) : super(key: key);

  final Function(String)? onStickerSelected;
  final KeyboardConfig keyboardConfig;
  final StreamController<String> scrollStream;

  @override
  State<StickerPickerWidget> createState() => _StickerPickerWidgetState();
}

class _StickerPickerWidgetState extends State<StickerPickerWidget>
    with SingleTickerProviderStateMixin {
  final int initCategory = 0;
  final double tabBarHeight = 46;

  List<String> _allStickers = [];
  PageController? _pageController;
  TabController? _tabController;
  final List<String> _tabs = [''];
  List<StickerModel> _stickerModels = [];

  bool _loaded = false;
  @override
  void initState() {
    super.initState();
    _listAssets();

    _pageController = PageController(initialPage: initCategory)
      ..addListener((() => widget.scrollStream.add('showNav')));
  }

  Future _listAssets() async {
    // Load as String
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    // Decode to Map
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    // Filter by path
    _allStickers = manifestMap.keys
        .where((path) => path.startsWith('assets/stickers/'))
        .where(
          (path) =>
              path.endsWith(".webp") ||
              path.endsWith(".png") ||
              path.endsWith(".jpg") ||
              path.endsWith(".gif") ||
              path.endsWith(".jpeg"),
        )
        .toList();

    // Get tab titles
    List<String> tabsTitle = [];
    for (var i = 0; i < _allStickers.length; i++) {
      String s = _allStickers[i].split("/")[2];
      if (!tabsTitle.contains(s)) {
        tabsTitle.add(s);
      }
    }

    //Add titles to tab list and create tab controller
    _tabs.addAll(tabsTitle);
    _tabController = TabController(
        initialIndex: initCategory, length: _tabs.length, vsync: this)
      ..addListener(() => widget.scrollStream.add('showNav'));

    //Get stickers and group them based on tabs
    for (var i = 0; i < _tabs.length; i++) {
      if (i == 0) {
        //TODO Get recents here
      }
      List<String> assets = _allStickers
          .where((asset) => asset.contains("assets/stickers/${_tabs[i]}"))
          .toList();

      _stickerModels.add(
        StickerModel(
          title: _tabs[i],
          assetUrls: assets,
        ),
      );
    }

    _loaded = true;
    if (mounted) setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: widget.keyboardConfig.bgColor,
      child: _loaded
          ? Column(
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
                Flexible(
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
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return widget.keyboardConfig.noRecents;
                      }

                      return StickerDisplay(
                        stickerModel: _stickerModels[index],
                        keyboardConfig: widget.keyboardConfig,
                        onStickerSelected: widget.onStickerSelected,
                        scrollStream: widget.scrollStream,
                      );
                    },
                  ),
                ),
              ],
            )
          : const CircularProgressIndicator.adaptive(),
    );
  }
}
