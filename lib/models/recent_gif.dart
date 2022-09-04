import 'package:flutter_social_keyboard/models/giphy_gif.dart';

class RecentGiphyGif {
  /// Constructor
  RecentGiphyGif(this.gif, this.counter);

  /// Sticker instance
  final GiphyGif gif;

  /// Counter how often emoji has been used before
  int counter = 0;

  /// Parse RecentEmoji from json
  static RecentGiphyGif fromJson(dynamic json) {
    return RecentGiphyGif(
      GiphyGif.fromJson(json['gif'] as Map<String, dynamic>),
      json['counter'] as int,
    );
  }

  /// Encode RecentEmoji to json
  Map<String, dynamic> toJson() => {
        'gif': gif,
        'counter': counter,
      };
}
