import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_keyboard/utils/languages.dart';

/// KeyboardConfig for customizations
class KeyboardConfig {
  /// Constructor
  const KeyboardConfig({
    this.useEmoji = true,
    this.useGif = true,
    this.useSticker = true,
    this.giphyAPIKey,
    this.gifTabs = const ['Haha', 'Sad', 'Love', 'Reaction'],
    this.gifColumns = 3,
    this.gifVerticalSpacing = 5,
    this.gifHorizontalSpacing = 5,
    this.stickerColumns = 4,
    this.gifLang = GiphyLanguage.english,
    this.stickerHorizontalSpacing = 5,
    this.stickerVerticalSpacing = 5,
    this.emojiColumns = 7,
    this.emojiSizeMax = 32.0,
    this.emojiVerticalSpacing = 0,
    this.emojiHorizontalSpacing = 0,
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
    this.replaceRecentOnLimitExceed = false,
    this.noRecents = const Text(
      'No Recents',
      style: TextStyle(fontSize: 20, color: Colors.black26),
      textAlign: TextAlign.center,
    ),
    this.tabIndicatorAnimDuration = kTabScrollDuration,
    this.categoryIcons = const CategoryIcons(),
    this.buttonMode = ButtonMode.MATERIAL,
    this.withSafeArea = true,
    this.showBackSpace = true,
    this.showSearchButton = true,
  });

  ///Enable Emoji keyboard
  final bool useEmoji;

  ///Enable gif keyboard
  final bool useGif;

  ///Enable sticker keyboard
  final bool useSticker;

  /// Your Giphy API Key
  /// It is required when using gif
  /// You can get one from [https://developers.giphy.com/dashboard](https://developers.giphy.com/dashboard)
  final String? giphyAPIKey;

  /// Create tabs that would serve as categories for gifs from giphy
  /// Default is ['Haha', 'Sad', 'Love', 'Reaction']
  final List<String> gifTabs;

  /// Number of gifs per row
  final int gifColumns;

  /// Vertical spacing between gifs
  final double gifVerticalSpacing;

  /// Horizontal spacing between gifs
  final double gifHorizontalSpacing;

  /// Language giphy suppose to use in search
  /// Default is english [GiphyLanguage.english]
  final String gifLang;

  /// Number of stickers per row
  final int stickerColumns;

  /// Vertical spacing between stickers
  final double stickerVerticalSpacing;

  /// Horizontal spacing between stickers
  final double stickerHorizontalSpacing;

  /// Apply [SafeArea] widget around keyboard
  final bool withSafeArea;

  /// Show search button on the bottom nav
  final bool showSearchButton;

  /// Show backspace button on the bottom nav
  /// Backspace is normally used for deleting characters/emojis
  final bool showBackSpace;

  /// Number of emojis per row
  final int emojiColumns;

  /// Width and height the emoji will be maximal displayed
  /// Can be smaller due to screen size and amount of columns
  final double emojiSizeMax;

  /// Vertical spacing between emojis
  final double emojiVerticalSpacing;

  /// Horizontal spacing between emojis
  final double emojiHorizontalSpacing;

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

  /// Replace latest emoji/gif/sticker on recents list on limit exceed
  final bool replaceRecentOnLimitExceed;
}
