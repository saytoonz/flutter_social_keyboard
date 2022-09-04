import 'package:flutter_social_keyboard/flutter_social_keyboard.dart';

class StickersModel {
  late String tabTitle;
  List<Sticker> stickers = [];

  StickersModel({
    required this.tabTitle,
    this.stickers = const [],
  });
}
