import 'dart:convert';

import 'dart:math';

import 'package:flutter_social_keyboard/models/giphy_gif.dart';
import 'package:flutter_social_keyboard/models/keyboard_config.dart';
import 'package:flutter_social_keyboard/models/recent_gif.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GiphyGifPickerInternalUtils {
  /// Returns list of recently used GiphyGif from cache
  Future<List<RecentGiphyGif>> getRecentGiphyGifs() async {
    final prefs = await SharedPreferences.getInstance();
    var giphyGif = prefs.getString('recent_gifs');
    if (giphyGif == null) {
      return [];
    }
    var json = jsonDecode(giphyGif) as List<dynamic>;
    return json.map<RecentGiphyGif>(RecentGiphyGif.fromJson).toList();
  }

  /// Add an GiphyGif to recently used list or increase its counter
  Future<List<RecentGiphyGif>> addGiphyGifToRecentlyUsed(
      {required GiphyGif giphyGif,
      KeyboardConfig config = const KeyboardConfig()}) async {
    var recentGiphyGif = await getRecentGiphyGifs();
    var recentGifIndex =
        recentGiphyGif.indexWhere((element) => element.gif.url == giphyGif.url);
    if (recentGifIndex != -1) {
      // Already exist in recent list
      // Just update counter
      recentGiphyGif[recentGifIndex].counter++;
    } else if (recentGiphyGif.length == config.recentsLimit &&
        config.replaceRecentOnLimitExceed) {
      // Replace latest gif with the fresh one
      recentGiphyGif[recentGiphyGif.length - 1] = RecentGiphyGif(giphyGif, 1);
    } else {
      recentGiphyGif.add(RecentGiphyGif(giphyGif, 1));
    }
    // Sort by counter desc
    recentGiphyGif.sort((a, b) => b.counter - a.counter);
    // Limit entries to recentsLimit
    recentGiphyGif = recentGiphyGif.sublist(
        0, min(config.recentsLimit, recentGiphyGif.length));
    // save locally
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('recent_gifs', jsonEncode(recentGiphyGif));

    return recentGiphyGif;
  }
}
