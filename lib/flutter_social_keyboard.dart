import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_keyboard/models/keyboard_config.dart';
import 'package:flutter_social_keyboard/widgets/emoji_picker_widget.dart';

//Bottom bar height, bg-color, icon-color, active-icon-color
class FlutterSocialKeyboard extends StatefulWidget {
  final KeyboardConfig? keyboardConfig;
  const FlutterSocialKeyboard({Key? key, this.keyboardConfig})
      : super(key: key);

  @override
  State<FlutterSocialKeyboard> createState() => _FlutterSocialKeyboardState();
}

class _FlutterSocialKeyboardState extends State<FlutterSocialKeyboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: IndexedStack(
            index: _currentIndex,
            children: [
              EmojiPickerWidget(
                  keyboardConfig:
                      widget.keyboardConfig ?? const KeyboardConfig())
            ],
          ),
        ),
        Container(
          height: 50,
          padding: EdgeInsets.zero,
          decoration: const BoxDecoration(
            color: Color(0xFFF2F2F2),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(43, 52, 69, .1),
                offset: Offset(0, -5),
                spreadRadius: 10,
                blurRadius: 200,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  color: _currentIndex == 0
                      ? Config().iconColorSelected
                      : Config().iconColor,
                ),
                const SizedBox(
                  width: 15,
                ),
                _getImgIcon(
                  image: "icons8-gif-96.png",
                  size: 26,
                  color: _currentIndex == 1
                      ? Config().iconColorSelected
                      : Config().iconColor,
                ),
                const SizedBox(
                  width: 15,
                ),
                _getImgIcon(
                  image: "icons8-sticker-100.png",
                  color: _currentIndex == 2
                      ? Config().iconColorSelected
                      : Config().iconColor,
                ),
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
      ],
    );
  }

  Image _getImgIcon({
    required String image,
    required Color color,
    double size = 22,
  }) {
    return Image.asset(
      "icons/$image",
      package: 'flutter_social_keyboard',
      width: size,
      height: size,
      color: color,
    );
  }
}
