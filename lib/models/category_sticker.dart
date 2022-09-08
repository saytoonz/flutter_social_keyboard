import 'package:flutter_social_keyboard/models/sticker.dart';

class CategorySticker {
  late String category;
  List<Sticker> stickers = [];

  CategorySticker({
    required this.category,
    this.stickers = const [],
  });

  /// Copy method
  CategorySticker copyWith({String? category, List<Sticker>? stickers}) {
    return CategorySticker(
      category: category ?? this.category,
      stickers: stickers ?? this.stickers,
    );
  }
}
