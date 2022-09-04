class Sticker {
  late String category;
  late String assetUrl;

  Sticker({
    required this.assetUrl,
    required this.category,
  });

  static Sticker fromJson(dynamic json) {
    return Sticker(
      assetUrl: json["assetUrl"],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() => {
        'assetUrl': assetUrl,
        'category': category,
      };
}
