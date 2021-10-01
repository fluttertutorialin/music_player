import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controller/home_controller.dart';
import '../models/song_model.dart';
import 'blur_container.dart';

class NewSongPageView extends StatefulWidget {
  final List<SongModel> allSongs;
  final NowPlayingController controller;
  const NewSongPageView({
    Key? key,
    required this.allSongs,
    required this.controller,
  }) : super(key: key);

  @override
  State<NewSongPageView> createState() => _NewSongPageViewState();
}

class _NewSongPageViewState extends State<NewSongPageView> {
  List<SongModel> newSongs = [];

  @override
  Widget build(BuildContext context) {
    newSongs.addAll(widget.allSongs);
    newSongs.shuffle();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: SizedBox(
        height: 160,
        child: PageView(
          children: [
            for (int i = 0; i < 10; i++)
              GestureDetector(
                onTap: () {
                  if (!widget.controller.isAllSongPlaylist) {
                    widget.controller.changetoAllsongPlaylist(i);
                    widget.controller.player.play();
                  }
                  widget.controller.player.seek(Duration.zero, index: i);
                  widget.controller.player.play();
                },
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: BlurryContainer(
                        child: CachedNetworkImage(
                          imageUrl: newSongs[i].album!,
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        blur: 10,
                        bgColor: Colors.black12,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 160,
                      alignment: Alignment.bottomLeft,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black,
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.play, color: Colors.white),
                          const SizedBox(width: 10),
                          Flexible(
                            flex: 2,
                            child: Text(
                              newSongs[i].song!,
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
