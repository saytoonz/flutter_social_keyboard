import 'package:flutter_social_keyboard/models/sticker.dart';

class RecentSticker {
  /// Constructor
  RecentSticker(this.sticker, this.counter);

  /// Sticker instance
  final Sticker sticker;

  /// Counter how often emoji has been used before
  int counter = 0;

  /// Parse RecentEmoji from json
  static RecentSticker fromJson(dynamic json) {
    return RecentSticker(
      Sticker.fromJson(json['sticker'] as Map<String, dynamic>),
      json['counter'] as int,
    );
  }

  /// Encode RecentEmoji to json
  Map<String, dynamic> toJson() => {
        'sticker': sticker,
        'counter': counter,
      };
}
