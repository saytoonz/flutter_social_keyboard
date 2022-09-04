class StickerModel {
  late String title;
  List<String> assetUrls = [];

  StickerModel({
    required this.title,
    this.assetUrls = const [],
  });
}
