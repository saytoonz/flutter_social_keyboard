import 'dart:convert';

import 'dart:math';

import 'package:flutter_social_keyboard/models/giphy_gif.dart';
import 'package:flutter_social_keyboard/models/keyboard_config.dart';
import 'package:flutter_social_keyboard/models/recent_gif.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StickerPickerInternalUtils {
  /// Returns list of recently used Stickers from cache
  Future<List<RecentGiphyGif>> getRecentStickers() async {
    final prefs = await SharedPreferences.getInstance();
    var giphyGif = prefs.getString('recent_gifs');
    if (giphyGif == null) {
      return [];
    }
    var json = jsonDecode(giphyGif) as List<dynamic>;
    return json.map<RecentGiphyGif>(RecentGiphyGif.fromJson).toList();
  }

  /// Add an GiphyGif to recently used list or increase its counter
  Future<List<RecentGiphyGif>> addStickerToRecentlyUsed(
      {required GiphyGif giphyGif,
      KeyboardConfig config = const KeyboardConfig()}) async {
    var recentSticker = await getRecentStickers();
    var recentEmojiIndex =
        recentSticker.indexWhere((element) => element.gif.url == giphyGif.url);
    if (recentEmojiIndex != -1) {
      // Already exist in recent list
      // Just update counter
      recentSticker[recentEmojiIndex].counter++;
    } else if (recentSticker.length == config.recentsLimit &&
        config.replaceEmojiOnLimitExceed) {
      // Replace latest gif with the fresh one
      recentSticker[recentSticker.length - 1] = RecentGiphyGif(giphyGif, 1);
    } else {
      recentSticker.add(RecentGiphyGif(giphyGif, 1));
    }
    // Sort by counter desc
    recentSticker.sort((a, b) => b.counter - a.counter);
    // Limit entries to recentsLimit
    recentSticker = recentSticker.sublist(
        0, min(config.recentsLimit, recentSticker.length));
    // save locally
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('recent_gifs', jsonEncode(recentSticker));

    return recentSticker;
  }
}
