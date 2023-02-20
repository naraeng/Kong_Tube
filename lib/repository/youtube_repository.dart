import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:kong_tube/const/api.dart';
import 'package:kong_tube/model/video_model.dart';

class YoutubeRepository {
  static Future<List<VideoModel>> getVideos() async {
    final resp = await Dio().get(
      YOUTUBE_ARI_BASE_URL,
      queryParameters: {
        'channelId': KONG_CHANNEL_ID,
        'maxResults': 50,
        'key': API_KEY,
        'part': 'snippet',
        'order': 'date',
      },
    );

    final listWithData = resp.data['items'].where((item) =>
        item?['id']?['videoId'] != null && item?['snippet']?['title'] != null);

    return listWithData
        .map<VideoModel>((item) => VideoModel(
            id: item['id']['videoId'], title: item['snippet']['title']))
        .toList();
  }
}
