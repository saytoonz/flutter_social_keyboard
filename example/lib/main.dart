import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_social_keyboard/flutter_social_keyboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Emoji? selectedEmoji;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                    child: Text(
                  selectedEmoji?.emoji ?? "NO emoji selected",
                  style: const TextStyle(
                    fontSize: 40,
                  ),
                )),
              ),
              SizedBox(
                height: 250,
                child: FlutterSocialKeyboard(
                  onEmojiSelected: (Category category, Emoji emoji) {
                    // Do something when emoji is tapped (optional)
                    print(emoji.name);
                    print(emoji.emoji);
                    selectedEmoji = emoji;
                    setState(() {});
                  },
                  onGifSelected: (GiphyGif gif) {
                    // Do something when gif is tapped (optional)
                    print(gif.toJson());
                  },
                  onBackspacePressed: () {
                    // Do something when the user taps the backspace button (optional)
                  },
                  keyboardConfig: KeyboardConfig(
                    giphyAPIKey: "vkOdSI3QLuAopjBKdwzeLC0mTCRJXIQM",
                    gifTabs: ["Hey", "One", 'Haha', 'Sad', 'Love', 'Reaction'],
                    emojiColumns: 9,
                    emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
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
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black26,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    replaceEmojiOnLimitExceed: true,
                    tabIndicatorAnimDuration: kTabScrollDuration,
                    categoryIcons: const CategoryIcons(),
                    buttonMode: ButtonMode.CUPERTINO,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
