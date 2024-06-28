import 'package:dio/dio.dart';
import 'package:flutter_json/const/api.dart';
import 'package:flutter_json/model/video_model.dart';

class YoutubeRepository {
  static Future<List<VideoModel>> getVideos() async {
    final resp = await Dio().get(
      YOUTUBE_API_BASE_URL,
      // 오타 수정: YOUTUBE_API_BASE_RUL -> YOUTUBE_API_BASE_URL
      queryParameters: {
        'channelId': CF_CHANNEL_ID,
        'maxResults': 50,
        'key': API_KEY,
        'part': 'snippet',
        'order': 'date',
      },
    );

    // id와 snippet 가 존재하는 아이템 필터
    final listWithData = resp.data['items'].where(
      (item) =>
          item?['id']?['videoId'] != null && item?['snippet']?['title'] != null,
    );

    // 객체 반환 -> VideoModel 로 반환함
    return listWithData
        .map<VideoModel>(
          (item) => VideoModel(
              id: item['id']['videoId'], title: item['snippet']['title']),
        )
        .toList();
  }
}
