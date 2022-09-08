import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_social_keyboard/models/keyboard_config.dart';
import 'package:flutter_social_keyboard/models/recent_sticker.dart';
import 'package:flutter_social_keyboard/models/sticker.dart';
import 'package:flutter_social_keyboard/models/category_sticker.dart';
import 'package:flutter_social_keyboard/utils/sticker_picker_internal_utils.dart';
import 'package:flutter_social_keyboard/widgets/display/sticker_display.dart';

class StickerPickerWidget extends StatefulWidget {
  const StickerPickerWidget({
    Key? key,
    required this.keyboardConfig,
    this.onStickerSelected,
    required this.scrollStream,
  }) : super(key: key);

  final Function(Sticker)? onStickerSelected;
  final KeyboardConfig keyboardConfig;
  final StreamController<String> scrollStream;

  @override
  State<StickerPickerWidget> createState() => StickerPickerWidgetState();
}

class StickerPickerWidgetState extends State<StickerPickerWidget>
    with SingleTickerProviderStateMixin {
  final int initCategory = 0;
  final double tabBarHeight = 46;

  List<String> _allStickers = [];
  PageController? _pageController;
  TabController? _tabController;
  final List<String> _tabs = List.empty(growable: true); //[''];

  final List<CategorySticker> _categorySticker = List.empty(growable: true);

  List<RecentSticker> _recentSticker = List.empty(growable: true);

  bool _loaded = false;

  void updateRecentSticker(List<RecentSticker> recentSticker,
      {bool refresh = false}) {
    _recentSticker = recentSticker;
    _categorySticker[0] = _categorySticker[0]
        .copyWith(stickers: _recentSticker.map((e) => e.sticker).toList());
    if (mounted && refresh) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _listAssets();
    if (widget.keyboardConfig.showRecentsTab) {
      _tabs.add('');
    }

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
              (path.toLowerCase()).endsWith(".webp") ||
              (path.toLowerCase()).endsWith(".png") ||
              (path.toLowerCase()).endsWith(".jpg") ||
              (path.toLowerCase()).endsWith(".gif") ||
              (path.toLowerCase()).endsWith(".jpeg"),
        )
        .toList();

    //  Get folder names from categories and tab titles
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
    _updateStickers();
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

  // Initialize sticker data
  Future<void> _updateStickers() async {
    _categorySticker.clear();
    for (var i = 0; i < _tabs.length; i++) {
      if (i == 0 && widget.keyboardConfig.showRecentsTab) {
        List<Sticker> recents =
            (await StickerPickerInternalUtils().getRecentStickers())
                .map((e) => e.sticker)
                .toList();
        _categorySticker.add(CategorySticker(
          category: "Recents",
          stickers: recents,
        ));
      } else {
        List<Sticker> stickers = _allStickers
            .where((asset) => asset.contains("assets/stickers/${_tabs[i]}"))
            .toList()
            .map((e) => Sticker(assetUrl: e, category: _tabs[i]))
            .toList();
        _categorySticker.add(CategorySticker(
          category: _tabs[i],
          stickers: stickers,
        ));
      }
    }

    _loaded = true;
    if (mounted) setState(() {});
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
                      if (index == 0 && _categorySticker[0].stickers.isEmpty) {
                        return Center(
                          child: widget.keyboardConfig.noRecents,
                        );
                      }

                      return StickerDisplay(
                          stickerModel: _categorySticker[index],
                          keyboardConfig: widget.keyboardConfig,
                          onStickerSelected: widget.onStickerSelected,
                          scrollStream: widget.scrollStream,
                          onUpdateRecent: (recentSticker, refresh) =>
                              updateRecentSticker(
                                recentSticker,
                                refresh: refresh,
                              ));
                    },
                  ),
                ),
              ],
            )
          : const CircularProgressIndicator.adaptive(),
    );
  }
}
