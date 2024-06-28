import 'package:flutter/material.dart';
import 'package:flutter_json/component/custom_youtube_player.dart';
import 'package:flutter_json/model/video_model.dart';
import 'package:flutter_json/repository/youtube_repository.dart';

// 상태변화가 없는 위젯
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // 제목 가운데 정렬
        centerTitle: true,
        title: Text("유튜브 예제"),
        backgroundColor: Colors.black,
      ),
      // 비동기 작업의 결과를 기반으로 UI를 동적으로 업데이트하는 위젯
      //future : youtuberepository.getvideos메서드를 호출 -> 동영상 목록 가져오는 Future 객체에 전달
      body: FutureBuilder<List<VideoModel>>(
        future: YoutubeRepository.getVideos(),
        builder: (context, snapshot) {
          // api 호출 중 발생시 에러 메시지 표시
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          // true 인 경우  데이터를 가져오는 중일 때 로딩중 표시
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            physics: BouncingScrollPhysics(),
            children: snapshot.data!
                .map((e) => CustomYoutubePlayer(videoModel: e))
                .toList(),
          );
        },
      ),
    );
  }
}
