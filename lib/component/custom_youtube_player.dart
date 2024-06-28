import 'package:flutter/material.dart';
import 'package:flutter_json/model/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// 동영상을 재생할 수 있는 상태로 제공하는 역할
class CustomYoutubePlayer extends StatefulWidget {
  // 상위 위젯에서 입력받을 동영상 변수
  final VideoModel videoModel;

// CustomYoutubePlayer 의 생성자
  const CustomYoutubePlayer({
    // 필수 매개변수로서, 상위 위젯으로부터 동영상 정보를 받아옴
    required this.videoModel,
    Key? key,
  }) : super(key: key);

  // 상태 객체를 생성하는 createState 메서드
  @override
  State<StatefulWidget> createState() => _CustomYoutubePlayerState();
}

class _CustomYoutubePlayerState extends State<CustomYoutubePlayer> {
  //인스턴스를 저장하는 변수
  YoutubePlayerController? controller;

  // 초기화 작업
  @override
  void initState() {
    super.initState();

    controller = YoutubePlayerController(
        // 초기화할 동영상의 ID를 상위 위젯에서 전달받은 videoModel.id 로 설정
        initialVideoId: widget.videoModel.id,
        flags: YoutubePlayerFlags(
          autoPlay: false,
        ));
  }

  @override
  //buildContext를 인자로 받아 화면에 표시될 위젯을 반환
  Widget build(BuildContext context) {
    // Column 위젯을 수직으로 배치
    return Column(
      // 자식 위젯들을 가로 방향으로 최대한 stretch
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 동영상을 재생하는 위젯
        YoutubePlayer(
          // 동영상 제어
          controller: controller!,
          // 동영상 로딩 중에 프로그레스 바를 표시함
          showVideoProgressIndicator: true,
        ),
        // 위젯 사이의 일정한 간격을 만듦
        const SizedBox(
          height: 16.0,
        ),
        // 자식 위젯에 패딩을 추가하여 여백을 만듬
        Padding(
          // 좌우에 패딩을 8.0 추가
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          // 텍스트 표시 위젯
          child: Text(
            // 부모 위젯에서 전달받은 videoModel 객체의 titl 속성을 표시
            // 즉 현재 재생 중인 동영상의 제목을 나타냄
            widget.videoModel.title, // 동영상 제목
            // 텍스트 스타일을 설정
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(
          height: 16.0,
        )
      ],
    );
  }

  // 위젯이 위젯트리에서 영구적으로 제거될 때 호출됨
  // 즉, 사용자가 화면을 벗어나거나 앱이 종료될 때 등의 상황에서 호출됨
  @override
  void dispose() {
    super.dispose();

    controller!.dispose();
  }
}
