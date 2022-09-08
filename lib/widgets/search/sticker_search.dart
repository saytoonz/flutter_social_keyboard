import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_social_keyboard/models/keyboard_config.dart';
import 'package:flutter_social_keyboard/models/sticker.dart';
import 'package:flutter_social_keyboard/utils/sticker_picker_internal_utils.dart';
import 'package:flutter_social_keyboard/utils/sticker_picker_utils.dart';

class StickerSearch extends StatefulWidget {
  const StickerSearch({
    super.key,
    required this.recents,
    required this.keyboardConfig,
    required this.onStickerSelected,
    required this.onCloseSearch,
  });
  final KeyboardConfig keyboardConfig;
  final List<Sticker> recents;
  final Function(Sticker)? onStickerSelected;
  final Function() onCloseSearch;

  @override
  State<StickerSearch> createState() => Calculates();
}

class Calculates extends State<StickerSearch> {
  final List<Sticker> stickers = List.empty(growable: true);
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    stickers.addAll(widget.recents);
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
      stickers.clear();
      stickers.addAll(widget.recents);
      setState(() {
        _isSearching = false;
      });
      return;
    }
    List<Sticker> result = await StickerPickerUtils().searchSticker(
      searchQuery: _textController.text,
      context: context,
    );
    stickers.clear();
    if (result.isNotEmpty) stickers.addAll(result);
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
                hintText: "Search Sticker",
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
              padding: widget.keyboardConfig.gridPadding,
              crossAxisCount: widget.keyboardConfig.stickerColumns,
              mainAxisSpacing: widget.keyboardConfig.stickerVerticalSpacing,
              crossAxisSpacing: widget.keyboardConfig.emojiHorizontalSpacing,
              children: [
                for (int i = 0; i < stickers.length; i++)
                  GestureDetector(
                    onTap: () {
                      if (widget.onStickerSelected != null) {
                        widget.onStickerSelected!(stickers[i]);
                        StickerPickerInternalUtils().addStickerToRecentlyUsed(
                          sticker: stickers[i],
                          config: widget.keyboardConfig,
                        );
                      }
                    },
                    child: Image.asset(
                      stickers[i].assetUrl,
                      errorBuilder: ((context, error, stackTrace) =>
                          const Icon(Icons.error)),
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
