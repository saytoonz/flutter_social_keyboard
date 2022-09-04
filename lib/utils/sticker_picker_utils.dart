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
  // final _emojiRegExp = RegExp(r'(\p{So})', unicode: true);

  /// Returns list of recently used stickers from cache
  Future<List<RecentSticker>> getRecentStickers() async {
    return StickerPickerInternalUtils().getRecentStickers();
  }

  /// Search for related emoticons based on keywords
  // Future<List<Emoji>> searchEmoji(String keyword, List<CategoryEmoji> data,
  //     {bool checkPlatformCompatibility = true}) async {
  //   if (keyword.isEmpty) return [];

  //   if (_allAvailableEmojiEntities.isEmpty) {
  //     final emojiPickerInternalUtils = EmojiPickerInternalUtils();

  //     final availableCategoryEmoji = checkPlatformCompatibility
  //         ? await emojiPickerInternalUtils.filterUnsupported(data)
  //         : data;

  //     // Set all the emoji entities
  //     for (var emojis in availableCategoryEmoji) {
  //       _allAvailableEmojiEntities.addAll(emojis.emoji);
  //     }
  //   }

  //   return _allAvailableEmojiEntities
  //       .where(
  //         (emoji) => emoji.name.toLowerCase().contains(keyword.toLowerCase()),
  //       )
  //       .toList();
  // }

  /// Add an emoji to recently used list or increase its counter
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
}
