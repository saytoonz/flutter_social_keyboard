import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_social_keyboard/models/keyboard_config.dart';
import 'package:flutter_social_keyboard/models/sticker.dart';
import 'package:flutter_social_keyboard/models/sticker_model.dart';

class StickerDisplay extends StatefulWidget {
  final StickerModel stickerModel;
  final KeyboardConfig keyboardConfig;
  final Function(Sticker)? onStickerSelected;
  final StreamController<String> scrollStream;
  const StickerDisplay({
    Key? key,
    required this.stickerModel,
    required this.keyboardConfig,
    this.onStickerSelected,
    required this.scrollStream,
  }) : super(key: key);

  @override
  State<StickerDisplay> createState() => _StickerDisplayState();
}

class _StickerDisplayState extends State<StickerDisplay> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(() {
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          // print("Show Keyboard");
          widget.scrollStream.add("showNav");
        } else if (_scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          // print("Hide Keyboard");
          widget.scrollStream.add("hideNav");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.stickerModel.assetUrls.isEmpty
        ? const Center(
            child: Text(
              "There was an error, try again!",
            ),
          )
        : GridView.builder(
            itemCount: widget.stickerModel.assetUrls.length,
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            padding: widget.keyboardConfig.gridPadding,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.keyboardConfig.stickerColumns,
                crossAxisSpacing:
                    widget.keyboardConfig.stickerHorizontalSpacing,
                mainAxisSpacing: widget.keyboardConfig.stickerVerticalSpacing),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (widget.onStickerSelected != null) {
                    widget.onStickerSelected!(Sticker(
                      assetUrl: widget.stickerModel.assetUrls[index],
                      category: widget.stickerModel.title,
                    ));
                  }
                },
                child: Image.asset(
                  widget.stickerModel.assetUrls[index],
                  errorBuilder: ((context, error, stackTrace) =>
                      const Icon(Icons.error)),
                  fit: BoxFit.cover,
                ),
              );
            },
          );
  }
}
