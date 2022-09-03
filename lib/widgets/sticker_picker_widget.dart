import 'dart:convert';

import 'package:flutter/material.dart';

class StickerPickerWidget extends StatefulWidget {
  StickerPickerWidget({Key? key}) : super(key: key);

  @override
  State<StickerPickerWidget> createState() => _StickerPickerWidgetState();
}

class _StickerPickerWidgetState extends State<StickerPickerWidget> {
  List<String> _allStickers = [];
  Future _listAssets() async {
    // Load as String
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    // Decode to Map
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    // Filter by path
    final stickers = manifestMap.keys
        .where((path) => path.startsWith('assets/stickers/'))
        .toList();
    print(stickers);
  }

  @override
  void initState() {
    super.initState();
    _listAssets();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
