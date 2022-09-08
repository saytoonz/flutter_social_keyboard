import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_social_keyboard/models/giphy_gif.dart';
import 'package:flutter_social_keyboard/models/keyboard_config.dart';
import 'package:flutter_social_keyboard/utils/giphy_gif_picker_internal_utils.dart';
import 'package:flutter_social_keyboard/utils/giphy_gif_picker_utils.dart';

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
  final Function(GiphyGif)? onGifSelected;
  final Function() onCloseSearch;

  @override
  State<GiphyGifSearch> createState() => Calculates();
}

class Calculates extends State<GiphyGifSearch> {
  final List<GiphyGif?> giphyGifs = List.empty(growable: true);
  final TextEditingController _textController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    giphyGifs.addAll(widget.recents);
    _textController.addListener(_search);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  _search() async {
    setState(() {
      _isSearching = true;
    });
    if (_textController.text.isEmpty) {
      giphyGifs.clear();
      giphyGifs.addAll(widget.recents);
      setState(() {
        _isSearching = false;
      });
      return;
    }
    List<GiphyGif?> result = await GiphyGifPickerUtils().searchGiphyGif(
      searchQuery: _textController.text,
      keyboardConfig: widget.keyboardConfig,
    );
    giphyGifs.clear();
    if (result.isNotEmpty) giphyGifs.addAll(result);
    setState(() {
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.keyboardConfig.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                onPressed: widget.onCloseSearch,
                padding: const EdgeInsets.all(4.0),
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
              focusNode: _focusNode,
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
          Visibility(
            visible: _isSearching,
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.count(
              scrollDirection: Axis.vertical,
              // controller: widget.scrollController,
              // primary: false,
              padding: widget.keyboardConfig.gridPadding,
              crossAxisCount: widget.keyboardConfig.gifColumns,
              mainAxisSpacing: widget.keyboardConfig.gifVerticalSpacing,
              crossAxisSpacing: widget.keyboardConfig.gifHorizontalSpacing,
              children: [
                for (int i = 0; i < giphyGifs.length; i++)
                  GestureDetector(
                    onTap: () {
                      if (widget.onGifSelected != null) {
                        widget.onGifSelected!(giphyGifs[i]!);
                        GiphyGifPickerInternalUtils()
                            .addGiphyGifToRecentlyUsed(giphyGif: giphyGifs[i]!);
                      }
                    },
                    child: CachedNetworkImage(
                      imageUrl: giphyGifs[i]?.images?.previewGif?.url ?? "",
                      placeholder: (context, url) =>
                          const CircularProgressIndicator.adaptive(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
