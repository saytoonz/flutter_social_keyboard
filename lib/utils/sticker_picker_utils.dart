import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_social_keyboard/models/keyboard_config.dart';
import 'package:flutter_social_keyboard/models/recent_sticker.dart';
import 'package:flutter_social_keyboard/models/sticker.dart';
import 'package:flutter_social_keyboard/utils/sticker_picker_internal_utils.dart';
import 'package:flutter_social_keyboard/widgets/sticker_picker_widget.dart';

/// Helper class that provides extended usage
class StickerPickerUtils {
  /// Singleton Constructor
  factory StickerPickerUtils() {
    return _singleton;
  }

  StickerPickerUtils._internal();

  static final StickerPickerUtils _singleton = StickerPickerUtils._internal();
  // final List<Sticker> _allAvailableStickerEntities = [];

  /// Returns list of recently used stickers from cache
  Future<List<RecentSticker>> getRecentStickers() async {
    return StickerPickerInternalUtils().getRecentStickers();
  }

  /// Add a sticker to recently used list or increase its counter
  Future addStickerToRecentlyUsed({
    required GlobalKey<StickerPickerWidgetState> key,
    required Sticker sticker,
    KeyboardConfig keyboardConfig = const KeyboardConfig(),
  }) async {
    return StickerPickerInternalUtils()
        .addStickerToRecentlyUsed(sticker: sticker, config: keyboardConfig)
        .then((recentStickerList) =>
            key.currentState?.updateRecentSticker(recentStickerList));
  }

  /// Search stickers
  Future<List<Sticker>> searchSticker({
    required String searchQuery,
    required BuildContext context,
  }) async {
    //Get all Sticker assets

    // Load as String
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    // Decode to Map
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

// Filter by path
    List<Sticker> allStickers = manifestMap.keys
        .where((path) => path.startsWith('assets/stickers/'))
        .where(
          (path) =>
              (path.toLowerCase()).endsWith(".webp") ||
              (path.toLowerCase()).endsWith(".png") ||
              (path.toLowerCase()).endsWith(".jpg") ||
              (path.toLowerCase()).endsWith(".gif") ||
              (path.toLowerCase()).endsWith(".jpeg"),
        )
        .where((element) => element.split('/').last.contains(searchQuery))
        .toList()
        .map((assetUrl) =>
            Sticker(assetUrl: assetUrl, category: assetUrl.split('/')[2]))
        .toList();

    return allStickers;
  }
}
