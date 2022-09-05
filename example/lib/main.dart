import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_social_keyboard/flutter_social_keyboard.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  Emoji? selectedEmoji;
  GiphyGif? selectedGif;
  Sticker? selectedSticker;
  double _panelHeightOpen = 0;

  final PanelController _panelController = PanelController();

  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // controller
      _panelController.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .85;

    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SlidingUpPanel(
            controller: _panelController,
            maxHeight: _panelHeightOpen,
            minHeight: 70,
            parallaxOffset: 0,
            body: _body(),
            panelBuilder: (sc) => _panel(sc),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18.0),
              topRight: Radius.circular(18.0),
            ),
            onPanelSlide: (double pos) {
              if (_panelController.isPanelClosed) {
                _panelController.hide();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          children: [
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
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
                style: const TextStyle(
                  height: 1.0,
                  fontSize: 14,
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: "Search Giphy",
                  prefixIcon: Icon(
                    Icons.search,
                    size: 17,
                    color: Colors.grey,
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget _body() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Flutter Plugin Example'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectedEmoji?.emoji ?? "NO emoji selected",
                  style: const TextStyle(
                    fontSize: 40,
                  ),
                ),
                //
                const SizedBox(
                  height: 10,
                ),
                selectedGif != null
                    ? CachedNetworkImage(
                        imageUrl: selectedGif!.images!.previewGif!.url!,
                        fit: BoxFit.fitHeight,
                        height: 150,
                        errorWidget: ((context, url, error) =>
                            Text(error.toString())),
                        placeholder: ((context, url) =>
                            const CircularProgressIndicator.adaptive()),
                      )
                    : const Text(
                        "NO GIF selected",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                //
                const SizedBox(
                  height: 10,
                ),

                selectedSticker != null
                    ? Image.asset(
                        selectedSticker!.assetUrl,
                        height: 100,
                      )
                    : const Text(
                        "NO Sticker selected",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(
            height: 280,
            child: FlutterSocialKeyboard(
              onEmojiSelected: (Category category, Emoji emoji) {
                // Do something when emoji is tapped (optional)

                // print(emoji);
                setState(() {
                  selectedEmoji = emoji;
                });
              },
              onGifSelected: (GiphyGif gif) {
                // Do something when gif is tapped (optional)

                // print(gif);
                setState(() {
                  selectedGif = gif;
                });
              },
              onStickerSelected: (Sticker sticker) {
                // Do something when sticker is tapped (optional)
                // print(sticker.toJson());
                setState(() {
                  selectedSticker = sticker;
                });
              },
              onBackspacePressed: () {
                // Do something when the user taps the backspace button (optional)
                // print("Backspace button pres ");
              },
              onSearchButtonPressed: () {
                _panelController
                    .show()
                    .then((value) => _panelController.open());
                _focusNode.requestFocus();
              },
              keyboardConfig: KeyboardConfig(
                useEmoji: true,
                useGif: true,
                useSticker: true,

                giphyAPIKey: "vkOdSI3QLuAopjBKdwzeLC0mTCRJXIQM",
                gifTabs: ["Hey", "One", 'Haha', 'Sad', 'Love', 'Reaction'],
                gifHorizontalSpacing: 5,
                gifVerticalSpacing: 5,
                gifColumns: 3,
                gifLang: GiphyLanguage.english,
                //
                stickerColumns: 5,
                stickerHorizontalSpacing: 5,
                stickerVerticalSpacing: 5,
                //
                withSafeArea: true,
                //
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
                showBackSpace: true,
                showSearchButton: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
