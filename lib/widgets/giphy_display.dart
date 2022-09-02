import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_social_keyboard/flutter_social_keyboard.dart';
import 'package:flutter_social_keyboard/models/collection.dart';
import 'package:flutter_social_keyboard/resources/client.dart';

class GiphyDisplay extends StatefulWidget {
  final String searchKeyword;
  final KeyboardConfig keyboardConfig;
  final Function(GiphyGif)? onGifSelected;
  final StreamController<String> scrollStream;
  const GiphyDisplay({
    Key? key,
    required this.searchKeyword,
    required this.keyboardConfig,
    this.onGifSelected,
    required this.scrollStream,
  }) : super(key: key);

  @override
  State<GiphyDisplay> createState() => _GiphyDisplayState();
}

class _GiphyDisplayState extends State<GiphyDisplay> {
  late final _scrollController = ScrollController();

  late GiphyClient client =
      GiphyClient(apiKey: widget.keyboardConfig.giphyAPIKey ?? "");
  int _offset = 0;
  final int _limit = 30;

  bool _loaded = false;
  GiphyCollection? _collection;
  @override
  void initState() {
    super.initState();
    _getGifs();

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

  _increaseOffSet() {
    setState(() {
      _offset = _offset + 30;
      _loaded = true;
    });
  }

  _getGifs() async {
    setState(() {
      _loaded = false;
    });
    GiphyCollection? collection;
    if (widget.searchKeyword.isEmpty) {
      //Fetch recent
      collection = null;
    } else if (widget.searchKeyword == 'trending') {
      //Trending
      collection = await client.trending(
        offset: _offset,
        limit: _limit,
      );
    } else {
      //Search
      collection = await client.search(
        widget.searchKeyword,
        offset: _offset,
        limit: _limit,
      );
    }

    setState(() {
      _collection = collection;
    });
    _increaseOffSet();
  }

  @override
  Widget build(BuildContext context) {
    return !_loaded
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : (_collection?.data ?? []).isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("There was an error, try again!"),
                  InkWell(
                    onTap: () {
                      _getGifs();
                    },
                    child: Text(
                      "Retry",
                      style: TextStyle(
                        color: widget.keyboardConfig.iconColor,
                      ),
                    ),
                  )
                ],
              )
            : GridView.builder(
                itemCount: _collection!.data!.length,
                scrollDirection: Axis.vertical,
                controller: _scrollController,
                padding: widget.keyboardConfig.gridPadding,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.keyboardConfig.gifColumns,
                    crossAxisSpacing:
                        widget.keyboardConfig.gifHorizontalSpacing,
                    mainAxisSpacing: widget.keyboardConfig.gifVerticalSpacing),
                itemBuilder: (context, index) {
                  // return  Image.network(
                  //     _collection!.data![index]!.images!.previewGif!.url!);
                  return InkWell(
                    onTap: () {
                      if (widget.onGifSelected != null) {
                        widget.onGifSelected!(_collection!.data![index]!);
                      }
                    },
                    child: CachedNetworkImage(
                      imageUrl:
                          _collection!.data![index]!.images!.previewGif!.url!,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator.adaptive(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
  }
}
