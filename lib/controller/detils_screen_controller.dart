import 'dart:async';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class DetailsScreenController extends GetxController{

  int selectedPlayerIdx = 0;
bool isPlayed = false;
  List<StreamSubscription> streams = [];
  final player = AudioPlayer();
  setAudio({required String audio})
  async {
    await player.setAsset(audio);
  }

  @override
  void onInit() {
    super.onInit();
  }
  @override
  void dispose() {
    streams.forEach((it) => it.cancel());
    super.dispose();
  }
}