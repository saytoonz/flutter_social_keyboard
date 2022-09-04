import 'dart:convert';

import 'dart:math';

import 'package:flutter_social_keyboard/flutter_social_keyboard.dart';
import 'package:flutter_social_keyboard/models/recent_sticker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StickerPickerInternalUtils {
  /// Returns list of recently used Stickers from cache
  Future<List<RecentSticker>> getRecentStickers() async {
    final prefs = await SharedPreferences.getInstance();
    var sticker = prefs.getString('recent_stickers');
    if (sticker == null) {
      return [];
    }
    var json = jsonDecode(sticker) as List<dynamic>;
    return json.map<RecentSticker>(RecentSticker.fromJson).toList();
  }

  /// Add an sticker to recently used list or increase its counter
  Future<List<RecentSticker>> addStickerToRecentlyUsed(
      {required Sticker sticker,
      KeyboardConfig config = const KeyboardConfig()}) async {
    var recentSticker = await getRecentStickers();
    var recentEmojiIndex = recentSticker
        .indexWhere((element) => element.sticker.assetUrl == sticker.assetUrl);
    if (recentEmojiIndex != -1) {
      // Already exist in recent list
      // Just update counter
      recentSticker[recentEmojiIndex].counter++;
    } else if (recentSticker.length == config.recentsLimit &&
        config.replaceEmojiOnLimitExceed) {
      // Replace latest sticker with the fresh one
      recentSticker[recentSticker.length - 1] = RecentSticker(sticker, 1);
    } else {
      recentSticker.add(RecentSticker(sticker, 1));
    }
    // Sort by counter desc
    recentSticker.sort((a, b) => b.counter - a.counter);
    // Limit entries to recentsLimit
    recentSticker = recentSticker.sublist(
        0, min(config.recentsLimit, recentSticker.length));
    // save locally
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('recent_stickers', jsonEncode(recentSticker));

    return recentSticker;
  }
}
