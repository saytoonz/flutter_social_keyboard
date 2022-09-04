import 'dart:convert';

import 'package:flutter_social_keyboard/models/sticker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StickerPickerInternalUtils {
  /// Returns list of recently used emoji from cache
  Future<List<Sticker>> getRecentStickers() async {
    final prefs = await SharedPreferences.getInstance();
    var sticker = prefs.getString('recent_stickers');
    if (sticker == null) {
      return [];
    }
    var json = jsonDecode(sticker) as List<dynamic>;
    return json.map<Sticker>(Sticker.fromJson).toList();
  }
}
