import 'dart:math';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_keyboard/models/keyboard_config.dart';
import 'package:flutter_social_keyboard/widgets/triangle_decoration.dart';

class EmojiSearch extends StatefulWidget {
  const EmojiSearch({
    super.key,
    required this.emojiSize,
    required this.recents,
    required this.keyboardConfig,
    required this.onEmojiSelected,
    required this.onCloseSearch,
  });
  final KeyboardConfig keyboardConfig;
  final double emojiSize;
  final List<Emoji> recents;
  final Function(Emoji) onEmojiSelected;
  final Function() onCloseSearch;

  @override
  State<EmojiSearch> createState() => Calculates();
}

class Calculates extends State<EmojiSearch> {
  OverlayEntry? _overlay;
  final ScrollController _scrollController = ScrollController();
  final List<Emoji> emojis = List.empty(growable: true);
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emojis.addAll(widget.recents);
    _scrollController.addListener(_closeSkinToneDialog);
    _textController.addListener(_searchEmoji);
  }

  _searchEmoji() async {
    if (_textController.text.isEmpty) {
      emojis.clear();
      emojis.addAll(widget.recents);
      setState(() {});
      return;
    }
    List<Emoji> emojiResult =
        await EmojiPickerUtils().searchEmoji(_textController.text);
    emojis.clear();
    emojis.addAll(emojiResult);
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
            child: _buildPage(
              widget.emojiSize,
              emojis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(double emojiSize, List<Emoji> categoryEmoji) {
    // Build page normally
    return GestureDetector(
      onTap: _closeSkinToneDialog,
      child:
          // ListView(
          //   scrollDirection: Axis.horizontal,
          //   controller: _scrollController,
          //   children: [
          //     for (int i = 0; i < categoryEmoji.length; i++)
          //       _buildEmojiCell(emojiSize, categoryEmoji[i], i)
          //   ],
          // )
          GridView.count(
        scrollDirection: Axis.horizontal,
        // controller: widget.scrollController,
        // primary: false,
        // padding: widget.keyboardConfig.gridPadding,
        crossAxisCount: 4,
        // mainAxisSpacing: widget.keyboardConfig.verticalSpacing,
        // crossAxisSpacing: widget.keyboardConfig.horizontalSpacing,
        children: [
          for (int i = 0; i < categoryEmoji.length; i++)
            _buildEmojiCell(emojiSize, categoryEmoji[i], i)
        ],
      ),
    );
  }

  Widget _buildEmojiCell(double size, Emoji emoji, int index) {
    return _buildButtonWidget(
      onPressed: () {
        _closeSkinToneDialog();
        widget.onEmojiSelected(emoji);
        // EmojiPickerUtils().addEmojiToRecentlyUsed(
        //   key: EmojiPickerState,
        //   emoji: emoji,
        // );
      },
      onLongPressed: () {
        if (!emoji.hasSkinTone || !widget.keyboardConfig.enableSkinTones) {
          _closeSkinToneDialog();
          return;
        }
        _closeSkinToneDialog();
        _openSkinToneDialog(emoji, size, index);
      },
      child: _buildEmoji(
        size,
        emoji,
        widget.keyboardConfig.enableSkinTones,
      ),
    );
  }

  /// Build different Button based on ButtonMode
  Widget _buildButtonWidget(
      {required VoidCallback onPressed,
      VoidCallback? onLongPressed,
      required Widget child}) {
    if (widget.keyboardConfig.buttonMode == ButtonMode.MATERIAL) {
      return InkWell(
        onTap: onPressed,
        onLongPress: onLongPressed,
        child: child,
      );
    }
    if (widget.keyboardConfig.buttonMode == ButtonMode.CUPERTINO) {
      return GestureDetector(
        onLongPress: onLongPressed,
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          child: child,
        ),
      );
    }
    return GestureDetector(
      onLongPress: onLongPressed,
      onTap: onPressed,
      child: child,
    );
  }

  void _closeSkinToneDialog() {
    _overlay?.remove();
    _overlay = null;
  }

  void _openSkinToneDialog(Emoji emoji, double emojiSize, int index) {
    _overlay = _buildSkinToneOverlay(
      emoji,
      emojiSize,
      index,
    );
    Overlay.of(context)?.insert(_overlay!);
  }

  Widget _buildEmoji(
      double emojiSize, Emoji emoji, bool showSkinToneIndicator) {
    final style = TextStyle(
      fontSize: emojiSize,
      backgroundColor: Colors.transparent,
    );
    final emojiText = Text(
      emoji.emoji,
      textScaleFactor: 1.0,
      style: style,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: emoji.hasSkinTone && showSkinToneIndicator
            ? Container(
                decoration: TriangleDecoration(color: Colors.red, size: 8.0),
                child: emojiText,
              )
            : emojiText,
      ),
    );
  }

  /// Overlay for SkinTone
  OverlayEntry _buildSkinToneOverlay(Emoji emoji, double emojiSize, int index) {
    // Calculate position of emoji in the grid
    final row = index ~/ widget.keyboardConfig.emojiColumns;
    final column = emojis.length; // index % widget.keyboardConfig.emojiColumns;
    // Calculate position for skin tone dialog
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final emojiSpace =
        renderBox.size.width / widget.keyboardConfig.emojiColumns;
    final leftOffset = _getLeftOffset(emojiSpace, column);
    final left = offset.dx + column * emojiSpace + leftOffset;
    final top = offset.dy + 240 / 4;

    // Generate other skintone options
    final skinTonesEmoji = SkinTone.values
        .map((skinTone) => applySkinTone(emoji, skinTone))
        .toList();

    return OverlayEntry(
      builder: (context) => Positioned(
        left: left,
        top: top,
        child: Material(
          elevation: 4.0,
          child: _buildBackgroundContainer(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            color: widget.keyboardConfig.skinToneDialogBgColor,
            child: Row(
              children: [
                _buildSkinToneEmoji(emoji, emojiSpace, emojiSize),
                _buildSkinToneEmoji(skinTonesEmoji[0], emojiSpace, emojiSize),
                _buildSkinToneEmoji(skinTonesEmoji[1], emojiSpace, emojiSize),
                _buildSkinToneEmoji(skinTonesEmoji[2], emojiSpace, emojiSize),
                _buildSkinToneEmoji(skinTonesEmoji[3], emojiSpace, emojiSize),
                _buildSkinToneEmoji(skinTonesEmoji[4], emojiSpace, emojiSize),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build Emoji inside skin tone dialog
  Widget _buildSkinToneEmoji(Emoji emoji, double width, double emojiSize) {
    return SizedBox(
      width: width,
      height: width,
      child: _buildButtonWidget(
        onPressed: () {
          widget.onEmojiSelected(emoji);
          _closeSkinToneDialog();
        },
        child: _buildEmoji(emojiSize, emoji, false),
      ),
    );
  }

  Widget _buildBackgroundContainer({
    required Color color,
    required Widget child,
    EdgeInsets? padding,
  }) {
    if (widget.keyboardConfig.buttonMode == ButtonMode.MATERIAL) {
      return Material(
        color: color,
        child: padding == null
            ? child
            : Padding(
                padding: padding,
                child: child,
              ),
      );
    } else {
      return Container(
        color: color,
        padding: padding,
        child: child,
      );
    }
  }

  // Calculates the offset from the middle of selected emoji to the left side
  double _getLeftOffset(double emojiWidth, int column) {
    var remainingColumns =
        widget.keyboardConfig.emojiColumns - (column + 1 + (6 ~/ 2));
    if (column >= 0 && column < 3) {
      return -1 * column * emojiWidth;
    } else if (remainingColumns < 0) {
      return -1 * ((6 ~/ 2 - 1) + -1 * remainingColumns) * emojiWidth;
    }
    return -1 * ((6 ~/ 2) * emojiWidth) + emojiWidth / 2;
  }

  //////
  ///
  ///
  ///
  ///
  ///
  ///
  /// Applies skin tone to given emoji
  Emoji applySkinTone(Emoji emoji, String color) {
    final codeUnits = emoji.emoji.codeUnits;
    var result = List<int>.empty(growable: true)
      ..addAll(codeUnits.sublist(0, min(codeUnits.length, 2)))
      ..addAll(color.codeUnits);
    if (codeUnits.length >= 2) {
      result.addAll(codeUnits.sublist(2));
    }
    return emoji.copyWith(emoji: String.fromCharCodes(result));
  }
}

/// Alternative skin tones of Emoji
class SkinTone {
  SkinTone._();

  /// Light Skin Tone
  static const String light = '🏻';

  /// Medium-Light Skin Tone
  static const String mediumLight = '🏼';

  /// Medium Skin Tone
  static const String medium = '🏽';

  /// Medium-Dark Skin Tone
  static const String mediumDark = '🏾';

  /// Dark Skin Tone
  static const String dark = '🏿';

  /// Return all values as Array
  static const values = [light, mediumLight, medium, mediumDark, dark];
}
