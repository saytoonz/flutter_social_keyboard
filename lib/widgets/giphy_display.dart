import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_social_keyboard/models/collection.dart';
import 'package:flutter_social_keyboard/models/gif.dart';
import 'package:flutter_social_keyboard/models/keyboard_config.dart';
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
  ScrollController _scrollController = ScrollController();

  late GiphyClient client =
      GiphyClient(apiKey: widget.keyboardConfig.giphyAPIKey ?? "");
  int _offset = 0;
  final int _limit = 30;

  bool _loaded = false;
  bool _loadingMore = true;

  GiphyCollection? _collection;
  @override
  void initState() {
    _scrollController = ScrollController();
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

        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.position.pixels;
        // Once it's less than 200px to reach bottom, do something
        double delta = 200.0;

        if (maxScroll - currentScroll <= delta && !_loadingMore) {
          _loadMore();
        }
      });
    });
  }

  _increaseOffSet() {
    setState(() {
      _offset = _offset + 30;
      _loaded = true;
      _loadingMore = false;
    });
  }

  _getGifs() async {
    setState(() {
      _loaded = false;
    });
    GiphyCollection? collection;

    try {
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
    } catch (e) {
      setState(() {
        _collection = null;
        _loaded = true;
      });
    }
  }

  _loadMore() async {
    setState(() {
      _loadingMore = true;
    });
    GiphyCollection? collection;

    try {
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
      _collection!.data!.addAll(collection!.data!);
      setState(() {});
      _increaseOffSet();
    } catch (e) {
      setState(() {
        _loadingMore = false;
      });
    }
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
            : SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    GridView.builder(
                      itemCount: _collection!.data!.length,
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.vertical,
                      // controller: _scrollController,
                      padding: widget.keyboardConfig.gridPadding,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: widget.keyboardConfig.gifColumns,
                          crossAxisSpacing:
                              widget.keyboardConfig.gifHorizontalSpacing,
                          mainAxisSpacing:
                              widget.keyboardConfig.gifVerticalSpacing),
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
                            imageUrl: _collection!
                                .data![index]!.images!.previewGif!.url!,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator.adaptive(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                    Visibility(
                      visible: _loadingMore,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: CircularProgressIndicator.adaptive(
                                // backgroundColor: Colors.red,
                                ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
  }
}
