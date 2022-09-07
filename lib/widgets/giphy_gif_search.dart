import 'package:flutter/material.dart';
import 'package:flutter_social_keyboard/flutter_social_keyboard.dart';

class GiphyGifSearch extends StatefulWidget {
  const GiphyGifSearch({
    super.key,
    required this.recents,
    required this.keyboardConfig,
    required this.onGifSelected,
    required this.onCloseSearch,
  });
  final KeyboardConfig keyboardConfig;
  final List<GiphyGif> recents;
  final Function(GiphyGif) onGifSelected;
  final Function() onCloseSearch;

  @override
  State<GiphyGifSearch> createState() => Calculates();
}

class Calculates extends State<GiphyGifSearch> {
  final List<GiphyGif> giphyGifs = List.empty(growable: true);
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    giphyGifs.addAll(widget.recents);
    _textController.addListener(_searchEmoji);
  }

  _searchEmoji() async {
    if (_textController.text.isEmpty) {
      giphyGifs.clear();
      giphyGifs.addAll(widget.recents);
      setState(() {});
      return;
    }
    List<GiphyGif> emojiResult =
        await GiphyGifPickerUtils().searchGiphyGif(_textController.text);
    giphyGifs.clear();
    giphyGifs.addAll(emojiResult);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.keyboardConfig.bgColor,
      height: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                onPressed: widget.onCloseSearch,
                icon: const Icon(
                  Icons.close,
                ),
              ),
            ],
          ),
          Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              // focusNode: _focusNode,
              controller: _textController,
              style: const TextStyle(
                height: 1.0,
                fontSize: 14,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                alignLabelWithHint: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: "Search Giphy",
                hintStyle: TextStyle(
                  color: Colors.grey.shade700,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 17,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              scrollDirection: Axis.horizontal,
              // controller: widget.scrollController,
              // primary: false,
              // padding: widget.keyboardConfig.gridPadding,
              crossAxisCount: 4,
              // mainAxisSpacing: widget.keyboardConfig.verticalSpacing,
              // crossAxisSpacing: widget.keyboardConfig.horizontalSpacing,
              children: [
                for (int i = 0; i < giphyGifs.length; i++) Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
