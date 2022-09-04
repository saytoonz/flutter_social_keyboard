import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

/// KeyboardConfig for customizations
class KeyboardConfig {
  /// Constructor
  const KeyboardConfig({
    this.giphyAPIKey,
    this.gifTabs = const ['Haha', 'Sad', 'Love', 'Reaction'],
    this.gifColumns = 3,
    this.gifVerticalSpacing = 5,
    this.gifHorizontalSpacing = 5,
    this.stickerColumns = 4,
    this.stickerHorizontalSpacing = 5,
    this.stickerVerticalSpacing = 5,
    this.emojiColumns = 7,
    this.emojiSizeMax = 32.0,
    this.verticalSpacing = 0,
    this.horizontalSpacing = 0,
    this.gridPadding = EdgeInsets.zero,
    this.initCategory = Category.RECENT,
    this.bgColor = const Color(0xFFEBEFF2),
    this.indicatorColor = Colors.blue,
    this.iconColor = Colors.grey,
    this.iconColorSelected = Colors.blue,
    this.progressIndicatorColor = Colors.blue,
    this.backspaceColor = Colors.blue,
    this.skinToneDialogBgColor = Colors.white,
    this.skinToneIndicatorColor = Colors.grey,
    this.enableSkinTones = true,
    this.showRecentsTab = true,
    this.recentsLimit = 28,
    this.replaceEmojiOnLimitExceed = false,
    this.noRecents = const Text(
      'No Recents',
      style: TextStyle(fontSize: 20, color: Colors.black26),
      textAlign: TextAlign.center,
    ),
    this.tabIndicatorAnimDuration = kTabScrollDuration,
    this.categoryIcons = const CategoryIcons(),
    this.buttonMode = ButtonMode.MATERIAL,
    this.withSafeArea = true,
  });

  final String? giphyAPIKey;
  final List<String> gifTabs;
  final int gifColumns;
  final double gifVerticalSpacing;
  final double gifHorizontalSpacing;

  final int stickerColumns;
  final double stickerVerticalSpacing;
  final double stickerHorizontalSpacing;
  final bool withSafeArea;

  /// Number of emojis per row
  final int emojiColumns;

  /// Width and height the emoji will be maximal displayed
  /// Can be smaller due to screen size and amount of columns
  final double emojiSizeMax;

  /// Vertical spacing between emojis
  final double verticalSpacing;

  /// Horizontal spacing between emojis
  final double horizontalSpacing;

  /// The initial [Category] that will be selected
  /// This [Category] will have its button in the bottomBar darkened
  final Category initCategory;

  /// The background color of the Widget
  final Color bgColor;

  /// The color of the category indicator
  final Color indicatorColor;

  /// The color of the category icons
  final Color iconColor;

  /// The color of the category icon when selected
  final Color iconColorSelected;

  /// The color of the loading indicator during initialization
  final Color progressIndicatorColor;

  /// The color of the backspace icon button
  final Color backspaceColor;

  /// The background color of the skin tone dialog
  final Color skinToneDialogBgColor;

  /// Color of the small triangle next to multiple skin tone emoji
  final Color skinToneIndicatorColor;

  /// Enable feature to select a skin tone of certain emoji's
  final bool enableSkinTones;

  /// Show extra tab with recently used emoji
  final bool showRecentsTab;

  /// Limit of recently used emoji that will be saved
  final int recentsLimit;

  /// A widget (usually [Text]) to be displayed if no recent emojis to display
  final Widget noRecents;

  /// Duration of tab indicator to animate to next category
  final Duration tabIndicatorAnimDuration;

  /// Determines the icon to display for each [Category]
  final CategoryIcons categoryIcons;

  /// Change between Material and Cupertino button style
  final ButtonMode buttonMode;

  /// The padding of GridView, default is [EdgeInsets.zero]
  final EdgeInsets gridPadding;

  /// Replace latest emoji on recents list on limit exceed
  final bool replaceEmojiOnLimitExceed;
}
