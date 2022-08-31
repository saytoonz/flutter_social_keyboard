import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

//Bottom bar height, bg-color
class FlutterSocialKeyboard extends StatefulWidget {
  const FlutterSocialKeyboard({Key? key}) : super(key: key);

  @override
  State<FlutterSocialKeyboard> createState() => _FlutterSocialKeyboardState();
}

class _FlutterSocialKeyboardState extends State<FlutterSocialKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: EmojiPicker(
            onEmojiSelected: (Category category, Emoji emoji) {
              // Do something when emoji is tapped (optional)
              print(emoji.name);
              print(emoji.emoji);
            },
            onBackspacePressed: () {
              // Do something when the user taps the backspace button (optional)
            },
            // textEditingController:
            //     textEditionController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
            config: Config(
              columns: 7,
              emojiSizeMax: 32 *
                  (Platform.isIOS
                      ? 1.30
                      : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
              verticalSpacing: 0,
              horizontalSpacing: 0,
              gridPadding: EdgeInsets.zero,
              initCategory: Category.RECENT,
              bgColor: const Color(0xFFF2F2F2),
              indicatorColor: Colors.blue,
              iconColor: Colors.grey,
              iconColorSelected: Colors.blue,
              progressIndicatorColor: Colors.blue,
              backspaceColor: Colors.blue,
              skinToneDialogBgColor: Colors.white,
              skinToneIndicatorColor: Colors.grey,
              enableSkinTones: true,
              showRecentsTab: true,
              recentsLimit: 28,
              noRecents: const Text(
                'No Recents',
                style: TextStyle(fontSize: 20, color: Colors.black26),
                textAlign: TextAlign.center,
              ),
              // tabIndicatorAnimDuration: kTabScrollDuration,
              categoryIcons: const CategoryIcons(),
              buttonMode: ButtonMode.MATERIAL,
            ),
          ),
        ),
        Container(
          height: 50,
          padding: EdgeInsets.zero,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(43, 52, 69, .1),
                offset: Offset(0, 3),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "😃",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
