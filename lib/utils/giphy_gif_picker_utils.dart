import 'package:flutter/material.dart';
import 'package:flutter_social_keyboard/models/collection.dart';
import 'package:flutter_social_keyboard/models/giphy_gif.dart';
import 'package:flutter_social_keyboard/models/keyboard_config.dart';
import 'package:flutter_social_keyboard/models/recent_gif.dart';
import 'package:flutter_social_keyboard/resources/client.dart';
import 'package:flutter_social_keyboard/utils/giphy_gif_picker_internal_utils.dart';

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
    // required GlobalKey<GiphyDisplayState> key,
    required GiphyGif giphyGif,
    KeyboardConfig keyboardConfig = const KeyboardConfig(),
  }) async {
    return GiphyGifPickerInternalUtils()
        .addGiphyGifToRecentlyUsed(giphyGif: giphyGif, config: keyboardConfig);
    // .then((recentStickerList) =>
    //     key.currentState?.updateRecentGiphyGifs(recentStickerList));
  }

  Future<List<GiphyGif?>> searchGiphyGif(
      {required String searchQuery,
      required KeyboardConfig keyboardConfig}) async {
    if ((keyboardConfig.giphyAPIKey ?? "").isEmpty) return [];

    try {
      GiphyClient client = GiphyClient(apiKey: keyboardConfig.giphyAPIKey!);
      GiphyCollection collection = await client.search(
        searchQuery,
        offset: 0,
        limit: 50,
        lang: keyboardConfig.gifLang,
      );
      return collection.data ?? [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
