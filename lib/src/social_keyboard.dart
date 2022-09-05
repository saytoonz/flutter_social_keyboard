import 'dart:async';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_social_keyboard/models/giphy_gif.dart';
import 'package:flutter_social_keyboard/models/keyboard_config.dart';
import 'package:flutter_social_keyboard/models/sticker.dart';
import 'package:flutter_social_keyboard/widgets/emoji_picker_widget.dart';
import 'package:flutter_social_keyboard/widgets/gif_picker_widget.dart';
import 'package:flutter_social_keyboard/widgets/sticker_picker_widget.dart';

//Bottom bar height, bg-color, icon-color, active-icon-color
//
class FlutterSocialKeyboard extends StatefulWidget {
  final KeyboardConfig keyboardConfig;
  final Function(Category, Emoji)? onEmojiSelected;
  final Function()? onBackspacePressed;
  final Function()? onSearchButtonPressed;
  final Function(GiphyGif)? onGifSelected;
  final Function(Sticker)? onStickerSelected;
  const FlutterSocialKeyboard({
    Key? key,
    this.keyboardConfig = const KeyboardConfig(),
    this.onEmojiSelected,
    this.onGifSelected,
    this.onBackspacePressed,
    this.onStickerSelected,
    this.onSearchButtonPressed,
  }) : super(key: key);

  @override
  State<FlutterSocialKeyboard> createState() => _FlutterSocialKeyboardState();
}

class _FlutterSocialKeyboardState extends State<FlutterSocialKeyboard> {
  final StreamController<String> scrollStream =
      StreamController<String>.broadcast();
  int _currentIndex = 0;
  bool _showBottomNav = true;

  final List<Widget> _showingWidgets = List.empty(growable: true);
  final List<String> _showingTabItems = List.empty(growable: true);
  @override
  void initState() {
    super.initState();

    if (widget.keyboardConfig.useEmoji) {
      _showingWidgets.add(
          //Emoji
          EmojiPickerWidget(
        keyboardConfig: widget.keyboardConfig,
        onBackspacePressed: widget.onBackspacePressed,
        onEmojiSelected: widget.onEmojiSelected,
      ));
      _showingTabItems.add("icons8-emoji-96.png");
    }

    if (widget.keyboardConfig.useGif) {
      _showingWidgets.add(
        //Gif
        GifPickerWidget(
          keyboardConfig: widget.keyboardConfig,
          onGifSelected: widget.onGifSelected,
          scrollStream: scrollStream,
        ),
      );
      _showingTabItems.add("icons8-gif-96.png");
    }

    if (widget.keyboardConfig.useSticker) {
      _showingWidgets.add(
        //Sticker
        StickerPickerWidget(
          keyboardConfig: widget.keyboardConfig,
          onStickerSelected: widget.onStickerSelected,
          scrollStream: scrollStream,
        ),
      );
      _showingTabItems.add("icons8-sticker-100.png");
    }

    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollStream.stream.listen((event) {
        if (event == "hideNav") {
          if (_showBottomNav) {
            setState(() {
              _showBottomNav = false;
            });
          }
        } else {
          if (!_showBottomNav) {
            setState(() {
              _showBottomNav = true;
            });
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: widget.keyboardConfig.withSafeArea && _showBottomNav,
      top: widget.keyboardConfig.withSafeArea,
      left: widget.keyboardConfig.withSafeArea,
      right: widget.keyboardConfig.withSafeArea,
      child: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: _showingWidgets,
            ),
          ),
          //Bottom navigation
          Visibility(
            visible: _showBottomNav,
            child: Container(
              height: 50,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: widget.keyboardConfig.bgColor,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(43, 52, 69, .1),
                    offset: Offset(0, -5),
                    spreadRadius: 10,
                    blurRadius: 200,
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: widget.keyboardConfig.showSearchButton ? 1 : 0,
                      child: IconButton(
                        onPressed: () {
                          if (!widget.keyboardConfig.showSearchButton) return;
                          //
                          widget.onSearchButtonPressed!();
                        },
                        icon: const Icon(
                          Icons.search,
                        ),
                      ),
                    ),
                    const Spacer(),
                    ..._showingTabItems
                        .map((e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7.5),
                              child: _getImgIcon(
                                image: e,
                                index: _showingTabItems.indexOf(e),
                                size: e.contains("gif") ? 26 : 22,
                              ),
                            ))
                        .toList(),
                    const Spacer(),
                    Opacity(
                      opacity: widget.keyboardConfig.showBackSpace &&
                              _showingTabItems[_currentIndex].contains("emoji")
                          ? 1
                          : 0,
                      child: IconButton(
                        onPressed: () {
                          if (!_showingTabItems[_currentIndex]
                                  .contains("emoji") ||
                              !widget.keyboardConfig.showBackSpace &&
                                  widget.onBackspacePressed == null) return;
                          widget.onBackspacePressed!();
                        },
                        icon: const Icon(
                          Icons.backspace_outlined,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getImgIcon({
    required String image,
    double size = 22,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Image.asset(
        "icons/$image",
        package: 'flutter_social_keyboard',
        width: size,
        height: size,
        color: _currentIndex == index
            ? widget.keyboardConfig.iconColorSelected
            : widget.keyboardConfig.iconColor,
      ),
    );
  }
}
