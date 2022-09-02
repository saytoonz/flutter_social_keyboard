import 'dart:async';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_social_keyboard/models/gif.dart';
import 'package:flutter_social_keyboard/models/keyboard_config.dart';
import 'package:flutter_social_keyboard/widgets/emoji_picker_widget.dart';
import 'package:flutter_social_keyboard/widgets/gif_picker_widget.dart';

//Bottom bar height, bg-color, icon-color, active-icon-color
//
class FlutterSocialKeyboard extends StatefulWidget {
  final KeyboardConfig keyboardConfig;
  final Function(Category, Emoji)? onEmojiSelected;
  final Function()? onBackspacePressed;
  final Function(GiphyGif)? onGifSelected;
  const FlutterSocialKeyboard({
    Key? key,
    this.keyboardConfig = const KeyboardConfig(),
    this.onEmojiSelected,
    this.onGifSelected,
    this.onBackspacePressed,
  }) : super(key: key);

  @override
  State<FlutterSocialKeyboard> createState() => _FlutterSocialKeyboardState();
}

class _FlutterSocialKeyboardState extends State<FlutterSocialKeyboard> {
  final StreamController<String> scrollStream =
      StreamController<String>.broadcast();
  int _currentIndex = 0;
  bool _showBottomNav = true;

  @override
  void initState() {
    super.initState();

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
              children: [
                //Emoji
                EmojiPickerWidget(
                  keyboardConfig: widget.keyboardConfig,
                  onBackspacePressed: widget.onBackspacePressed,
                  onEmojiSelected: widget.onEmojiSelected,
                ),
                //Gif
                GifPickerWidget(
                  keyboardConfig: widget.keyboardConfig,
                  onGifSelected: widget.onGifSelected,
                  scrollStream: scrollStream,
                ),
                Container(),
              ],
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                      ),
                    ),
                    const Spacer(),
                    _getImgIcon(
                      image: "icons8-emoji-96.png",
                      index: 0,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    _getImgIcon(
                      image: "icons8-gif-96.png",
                      size: 26,
                      index: 1,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    _getImgIcon(image: "icons8-sticker-100.png", index: 2),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.backspace_outlined,
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
