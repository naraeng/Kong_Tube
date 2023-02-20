import 'package:flutter/material.dart';
import 'package:kong_tube/component/custom_player.dart';
import 'package:kong_tube/model/video_model.dart';
import 'package:kong_tube/repository/youtube_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: Text('콩플리'),
          backgroundColor: Colors.black,
        ),
        body: FutureBuilder<List<VideoModel>>(
          future: YoutubeRepository.getVideos(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: snapshot.data!
                      .map((e) => CustomPlayer(videoModel: e))
                      .toList()),
            );
          }),
        ));
  }
}
