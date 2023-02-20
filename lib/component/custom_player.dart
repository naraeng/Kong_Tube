import 'package:flutter/material.dart';
import 'package:kong_tube/model/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomPlayer extends StatefulWidget {
  final VideoModel videoModel;
  const CustomPlayer({required this.videoModel, Key? key}) : super(key: key);

  @override
  State<CustomPlayer> createState() => _CustomPlayerState();
}

class _CustomPlayerState extends State<CustomPlayer> {
  YoutubePlayerController? controller;

  @override
  void initState() {
    super.initState();

    controller = YoutubePlayerController(
        initialVideoId: widget.videoModel.id,
        flags: YoutubePlayerFlags(
          autoPlay: false,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        YoutubePlayer(
          controller: controller!,
          showVideoProgressIndicator: true,
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            widget.videoModel.title,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();

    controller!.dispose();
  }
}
