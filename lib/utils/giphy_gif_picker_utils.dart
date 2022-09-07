import 'package:flutter/material.dart';
import 'package:flutter_social_keyboard/models/giphy_gif.dart';
import 'package:flutter_social_keyboard/models/keyboard_config.dart';
import 'package:flutter_social_keyboard/models/recent_gif.dart';
import 'package:flutter_social_keyboard/utils/giphy_gif_picker_internal_utils.dart';
import 'package:flutter_social_keyboard/widgets/giphy_display.dart';

/// Helper class that provides extended usage
class GiphyGifPickerUtils {
  /// Singleton Constructor
  factory GiphyGifPickerUtils() {
    return _singleton;
  }

  GiphyGifPickerUtils._internal();

  static final GiphyGifPickerUtils _singleton = GiphyGifPickerUtils._internal();

  /// Returns list of recently used gif from cache
  Future<List<RecentGiphyGif>> getRecentGiphyGif() async {
    return GiphyGifPickerInternalUtils().getRecentGiphyGifs();
  }

  /// Add a giphy gif to recently used list or increase its counter
  Future addGiphyGifToRecentlyUsed({
    required GlobalKey<GiphyDisplayState> key,
    required GiphyGif giphyGif,
    KeyboardConfig config = const KeyboardConfig(),
  }) async {
    return GiphyGifPickerInternalUtils()
        .addGiphyGifToRecentlyUsed(giphyGif: giphyGif, config: config)
        .then((recentStickerList) =>
            key.currentState?.updateRecentGiphyGifs(recentStickerList));
  }

  Future<List<GiphyGif>> searchGiphyGif(String se) async {}
}
