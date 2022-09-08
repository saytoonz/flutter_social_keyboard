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
    KeyboardConfig config = const KeyboardConfig(),
  }) async {
    return StickerPickerInternalUtils()
        .addStickerToRecentlyUsed(sticker: sticker, config: config)
        .then((recentStickerList) =>
            key.currentState?.updateRecentSticker(recentStickerList));
  }

  /// Search stickers
  Future<List<Sticker>> searchSticker({required String searchQuery}) async {
    //Get all Sticker assets
    return StickerPickerInternalUtils().getRecentStickers();
  }
}
