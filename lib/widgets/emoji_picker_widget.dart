import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_keyboard/models/keyboard_config.dart';

export 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class EmojiPickerWidget extends StatefulWidget {
  final KeyboardConfig keyboardConfig;
  const EmojiPickerWidget({Key? key, required this.keyboardConfig})
      : super(key: key);

  @override
  State<EmojiPickerWidget> createState() => _EmojiPickerWidgetState();
}

class _EmojiPickerWidgetState extends State<EmojiPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return EmojiPicker(
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
        columns: widget.keyboardConfig.columns,
        emojiSizeMax: widget.keyboardConfig.emojiSizeMax,
        verticalSpacing: widget.keyboardConfig.verticalSpacing,
        horizontalSpacing: widget.keyboardConfig.horizontalSpacing,
        gridPadding: widget.keyboardConfig.gridPadding,
        initCategory: widget.keyboardConfig.initCategory,
        bgColor: widget.keyboardConfig.bgColor,
        indicatorColor: widget.keyboardConfig.indicatorColor,
        iconColor: widget.keyboardConfig.iconColor,
        iconColorSelected: widget.keyboardConfig.iconColorSelected,
        progressIndicatorColor: widget.keyboardConfig.progressIndicatorColor,
        backspaceColor: widget.keyboardConfig.backspaceColor,
        skinToneDialogBgColor: widget.keyboardConfig.skinToneDialogBgColor,
        skinToneIndicatorColor: widget.keyboardConfig.skinToneIndicatorColor,
        enableSkinTones: widget.keyboardConfig.enableSkinTones,
        showRecentsTab: widget.keyboardConfig.showRecentsTab,
        recentsLimit: widget.keyboardConfig.recentsLimit,
        noRecents: widget.keyboardConfig.noRecents,
        tabIndicatorAnimDuration:
            widget.keyboardConfig.tabIndicatorAnimDuration,
        categoryIcons: widget.keyboardConfig.categoryIcons,
        buttonMode: widget.keyboardConfig.buttonMode,
      ),
    );
  }
}
