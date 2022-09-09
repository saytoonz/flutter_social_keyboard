
# flutter_social_keyboard

Fully customizable Emoji picker, Gif picker and Sticker for your flutter social media and chat applications

  > **Acknowledgment:** Much thanks to [Stefan Humm](https://github.com/Fintasys) for [emoji_picker_flutter](https://pub.dev/packages/emoji_picker_flutter).

## Preview
.
<img src="https://camo.githubusercontent.com/1471a5ace46d71b5871831b8ced3dd2a4e29b1cd28d628d97a7de38eff49c41e/68747470733a2f2f787269646567682e636f6d2f656d6f6a695f6d6f74696f6e2e77656270" width="220"> <img src="https://camo.githubusercontent.com/9919705af9b24a633ee80dc22e7192673727aecaf9c713d5c33bbf6e738408fa/68747470733a2f2f787269646567682e636f6d2f6769665f6d6f74696f6e2e77656270" width="220"> <img src="https://camo.githubusercontent.com/267103da0c359f98ea1bf2d2050c5072662f1e18c29519d8b3b878315ab356d1/68747470733a2f2f787269646567682e636f6d2f737469636b65725f6d6f74696f6e2e77656270" width="220">


## Support
If the package was useful or saved your time, please do not hesitate to buy me a cup of coffee! ;)  
The more caffeine I get, the more useful projects I can make in the future. 

<a href="https://www.buymeacoffee.com/saytoonz" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>


## Key features
- Access to Emoji, Gif and Sticker picker
- Giphy gifs
- Developer determined Stickers
- Lightweight Package
- Faster Loading
- Null-safety
- Material Design and Cupertino mode
- Emojis that cannot be displayed are filtered out (Android Only)
- Optional recently used tabs
- Skin Tone Support for emojis
- Completely customizable


## Getting Started

## Installation

Add Get to your pubspec.yaml file:

```yaml
dependencies:
  flutter_social_keyboard: <version>
```

Import get in files that it will be used:

```dart
import 'package:flutter_social_keyboard/flutter_social_keyboard.dart';
```
<br>

### Emoji setup
- Do nothing

### Gif setup
Package depends on [GIPHY GIF](https://giphy.com/)
- Sign up as [giphy developer](https://developers.giphy.com/dashboard) to optain API Key
- Giphy API Key is **required** to use the gif picker in this package


### Sticker setup
Package depends on your project asset for sticker images
- Create an **asset** folder in your project directory (name must be *asset*)
- Create a folder named **stickers** within the asset folder
- Create sub-folders in the sticker containing an the sticker asset files
<br>
<img src="https://camo.githubusercontent.com/1c294e4cf59f08b563039c3de1a7638ae8cc116fa428c503f6a364aef5945d84/68747470733a2f2f787269646567682e636f6d2f737469636b65722d666f6c6465722d73657475702e706e67" width="250">
<br>
- Folder names of the sub-folders in the sticker folders are considered as categories and tab names
- Supported files include .png, .gif, .webp, .jpg and .jpeg,
- Link all sticker folders in the pubspec.yaml file
<br>
<img src="https://camo.githubusercontent.com/30838e9dbc2ec71bcc53e9b0c8519dbe816488faae917959d5bfb77e557dc1b6/68747470733a2f2f787269646567682e636f6d2f737469636b65722d7075622d73657475702e706e67" width="250">
<br>



## Usage

```dart
FlutterSocialKeyboard(
  onEmojiSelected: (Category category, Emoji emoji) {
    // Do something when emoji is tapped (optional)
  },
  onGifSelected: (GiphyGif gif) {
    // Do something when gif is tapped (optional)
  },
  onStickerSelected: (Sticker sticker) {
    // Do something when sticker is tapped (optional)
  },
  onBackspacePressed: () {
    // Do something when the user taps the backspace button (optional)
  },
  keyboardConfig: KeyboardConfig(
    useEmoji: true, //Enable emoji picker
    useGif: true, //Enable gif picker
    useSticker: true, //Enable Sticker picker
    giphyAPIKey: "API KEY HERE", 
    gifTabs: ["Hey", "One", 'Haha', 'Sad', 'Love', 'Reaction'],
    gifHorizontalSpacing: 5,
    gifVerticalSpacing: 5,
    gifColumns: 3,
    gifLang: GiphyLanguage.english,
    stickerColumns: 5,
    stickerHorizontalSpacing: 5,
    stickerVerticalSpacing: 5,
    withSafeArea: true,
    emojiColumns: 9,
    emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
    emojiVerticalSpacing: 0,
    emojiHorizontalSpacing: 0,
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
    replaceRecentOnLimitExceed: true,
    tabIndicatorAnimDuration: kTabScrollDuration,
    categoryIcons: const CategoryIcons(),
    buttonMode: ButtonMode.CUPERTINO,
    showBackSpace: true,
    showSearchButton: true,
  ),
),

```
See the [demo](https://github.com/saytoonz/flutter_social_keyboard/blob/master/example/lib/main.dart) for more detailed sample project.

## KeyboardConfig

| property        | description                                                        | default    |
| --------------- | ------------------------------------------------------------------ |------------|
| useEmoji     | Enable Emoji keyboard                  | true |
| useGif     | Enable Gif keyboard                  | true |
| useSticker     | Enable Sticker keyboard                  | true |
| withSafeArea             | Apply [SafeArea] widget around keyboard                                       |true    |
| showSearchButton             | Show search button on the bottom nav                                       |true    |
| showBackSpace             | Show backspace button on the bottom nav                                       |7    |
| giphyAPIKey     | Your Giphy API Key. It is required when using gif. You can get one from [https://developers.giphy.com/dashboard](https://developers.giphy.com/dashboard)                 | null |
| gifTabs     | Create tabs that would serve as categories for gifs from giphy                  | ['Haha', 'Sad', 'Love', 'Reaction'] |
| gifColumns             | Number of gifs per row                                       |3    |
| gifVerticalSpacing             | Vertical spacing between gifs                                       |5    |
| gifHorizontalSpacing             | Horizontal spacing between gifs                                       |5    |
| gifLang             | Language giphy suppose to use in search                                       |GiphyLanguage.english    |
| stickerColumns             | Number of stickers per row                                       |4    |
| stickerVerticalSpacing             | Vertical spacing between stickers                                       |5    |
| stickerHorizontalSpacing             | Horizontal spacing between stickers                                       |5    |
| emojiColumns             | Number of emojis per row                                       |7    |
| emojiSizeMax     | Width and height the emoji will be maximal displayed                 |32.0  |
| emojiVerticalSpacing         | Vertical spacing between emojis | 0    |
| emojiHorizontalSpacing | Horizontal spacing between emojis                                                 | 0     |
| gridPadding | The padding of GridView                                                                              | EdgeInsets.zero                                                                                        |
| initCategory         | The initial Category that will be selected for the emoji picker                                                         |Category.RECENT   |
| bgColor       | The background color of the Widget                                                       |Color(0xFFF2F2F2)    |
| indicatorColor        | The color of the category indicator                                                       | Colors.blue      |
| iconColor    | The color of the category icons                                                       | Colors.grey      |
| iconColorSelected      | The color of the category icon when selected                                                 | Colors.blue |
| progressIndicatorColor     | The color of the loading indicator during initialization                                | Colors.blue     |
| backspaceColor     | The color of the backspace icon button                               | Colors.blue     |
| skinToneDialogBgColor     | The background color of the skin tone dialog                               | Colors.white     |
| skinToneIndicatorColor     | Color of the small triangle next to multiple skin tone emoji                               | Colors.grey     |
| enableSkinTones     | Enable feature to select a skin tone of certain emoji's                               | true     |
| showRecentsTab     | Show extra tab with recently used emoji, sticker or gif                                | true     |
| recentsLimit     | Limit of recently used emoji that will be saved                                | 28     |
| replaceEmojiOnLimitExceed | Replace latest emoji on recents list on limit exceed | false
| noRecents     |  A widget (usually [Text]) to be displayed if no recent emojis to display                                | Text('No Recents', style: TextStyle(fontSize: 20, color: Colors.black26), textAlign: TextAlign.center)     |
| loadingIndicator     |  A widget to display while emoji picker is initializing                                | SizedBox.shrink()     |
| tabIndicatorAnimDuration     | Duration of tab indicator to animate to next category                                | Duration(milliseconds: 300)     |
| categoryIcons     | Determines the icon to display for each Category. You can change icons by setting them in the constructor.                               | CategoryIcons()     |
| buttonMode     | Choose between Material and Cupertino button style                                | ButtonMode.MATERIAL     |
| checkPlatformCompatibility     | Whether to filter out glyphs that platform cannot render with the default font (Android).   | true     |
| emojiSet     | Custom emoji set, can be built based on `defaultEmojiSet` provided by the library.   | null    |
| emojiTextStyle     | Text style to apply to individual emoji icons. Can be used to define custom emoji font either with GoogleFonts library or bundled with the app.  | null    |



## Extended usage with EmojiPickerUtils

```dart
// Get recently used 
final recentEmojis = await EmojiPickerUtils().getRecentEmojis();

final recentStickers = await StickerPickerUtils().getRecentStickers();

final recentGifs = await GiphyGifPickerUtils().getRecentGiphyGif();



// Search for related emoticons, stickers and gifs based on keywords and names/titles
final filterEmojis = await EmojiPickerUtils().searchEmoji("face", defaultEmojiSet);

final filterStickers = await StickerPickerUtils().searchSticker("funny", context);

final filterGifs = await GiphyGifPickerUtils().searchGiphyGif("love", keyboardConfig);


/// Add an Emoji, Sticker and Gif to recently used list or increase its counter
final newRecentEmojis = await EmojiPickerUtils().addEmojiToRecentlyUsed(key: key, emoji: emoji); // Important: Needs same key instance of type GlobalKey<EmojiPickerState> here and for the EmojiPicker-Widget in order to work properly

final addRecentSticker = await StickerPickerUtils().addStickerToRecentlyUsed(key: key, sticker: sticker, keyboardConfig: keyboardConfig); // Important: Needs same key instance of type GlobalKey<StickerPickerWidgetState> here and for the StickerPicker-Widget in order to work properly

final addRecentGif = await GiphyGifPickerUtils().addGiphyGifToRecentlyUsed(giphyGif: giphyGif, keyboardConfig: keyboardConfig);


```

## Feel free to contribute to this package!! 🙇‍♂️
Always happy if anyone wants to help to improve this package!
<br>
<img src="https://camo.githubusercontent.com/c78124dfaa325b270bb3282bfebc47667064499bc79542764a357452708510aa/68747470733a2f2f787269646567682e636f6d2f456d6f6a6953686f742e504e47" width="250">
<img src="https://camo.githubusercontent.com/8f4d9f7c1e7c2a075f161fc54ed7873a0105d415e806330505bf6fcd48a90934/68747470733a2f2f787269646567682e636f6d2f476970687947696653686f742e504e47" width="250">
<img src="https://camo.githubusercontent.com/229679b23fb8676d1260692481e6d33bcf0eeac3eca9c18121d7ca615a14cb15/68747470733a2f2f787269646567682e636f6d2f537469636b657253686f742e504e47" width="250">

## Feature Requests and Issues
Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/saytoonz/flutter_social_keyboard/issues/new



<a href="https://www.buymeacoffee.com/saytoonz" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

## Connect with me
[<img align="left" alt="Sam | Twitter" width="22px" src="https://cdn.jsdelivr.net/npm/simple-icons@v3/icons/twitter.svg" />](https://twitter.com/saytoonz)
[<img align="left" alt="Sam | LinkedIn" width="22px" src="https://cdn.jsdelivr.net/npm/simple-icons@v3/icons/linkedin.svg" />](https://www.linkedin.com/in/samuel-annin-yeboah-427564142/)
[<img align="left" alt="Sam | Instagram" width="22px" src="https://cdn.jsdelivr.net/npm/simple-icons@v3/icons/instagram.svg" />](https://instagram.com/saytoonz)

<br>

## Visitors Count
<img align="left" src = "https://profile-counter.glitch.me/flutter_social_keyboard/count.svg" alt ="Loading">
