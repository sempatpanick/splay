import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../../common/enum.dart';

class MainController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();
  late AnimationController animationController;

  RxList<NavigationMenuData> navigationMenus = NavigationMenuData.values.obs;
  RxInt selectedNavigationMenu = 0.obs;

  RxInt seekDurationSecond = 10.obs;
  RxBool isRepeat = false.obs;
  RxDouble tmpVolume = 100.0.obs;
  RxDouble volume = 100.0.obs;
  RxDouble turns = 0.0.obs;
  RxBool isPlaying = false.obs;

  Rx<Duration> durationAudio = Duration.zero.obs;
  Rx<Duration> positionAudio = Duration.zero.obs;

  @override
  void dispose() {
    audioPlayer.dispose();
    animationController.dispose();

    super.dispose();
  }

  void changeSelectedNavigationMenu(NavigationMenuData menu) {
    final searchMenuIndex = navigationMenus.indexWhere((item) => item == menu);
    if (selectedNavigationMenu.value == searchMenuIndex) return;
    selectedNavigationMenu.value = searchMenuIndex;
  }

  Future<void> playOrPause() async {
    if (isPlaying.value) {
      setTurnsDecrement(1 / 4);
      animationController.reverse();
      await audioPlayer.pause();
    } else {
      setTurnsIncrement(1 / 4);
      animationController.forward();
      await audioPlayer.resume();
    }
    isPlaying.value = !isPlaying.value;
  }

  Future<void> changeSliderPosition(double value) async {
    final newPosition = Duration(seconds: value.toInt());
    await audioPlayer.seek(newPosition);

    if (isPlaying.value) {
      setTurnsIncrement(1 / 4);
      animationController.forward();
    } else {
      setTurnsDecrement(1 / 4);
      animationController.reverse();
    }

    await audioPlayer.resume();
  }

  Future<void> seekBackward() async {
    int calculateDurationSecond = positionAudio.value.inSeconds - seekDurationSecond.value;
    if (calculateDurationSecond < 0) {
      await audioPlayer.seek(const Duration(seconds: 0));
      return;
    }
    await audioPlayer.seek(positionAudio.value - Duration(seconds: seekDurationSecond.value));
  }

  Future<void> seekForward() async {
    int calculateDurationSecond = positionAudio.value.inSeconds + seekDurationSecond.value;
    if (calculateDurationSecond > durationAudio.value.inSeconds) {
      await audioPlayer.seek(durationAudio.value);
      return;
    }
    await audioPlayer.seek(positionAudio.value + Duration(seconds: seekDurationSecond.value));
  }

  void setTurnsIncrement(double value) {
    turns.value += value;
  }

  void setTurnsDecrement(double value) {
    turns.value -= value;
  }

  Future<void> changeVolume(double value) async {
    volume.value = value;
    await audioPlayer.setVolume(volume.value);
  }

  Future<void> changeIsRepeat() async {
    isRepeat.value = !isRepeat.value;

    if (isRepeat.value) {
      await audioPlayer.setReleaseMode(ReleaseMode.loop);
      return;
    }
    await audioPlayer.setReleaseMode(ReleaseMode.release);
  }

  Future<void> changeIsMute() async {
    if (volume.value > 0) {
      await audioPlayer.setVolume(0);
      tmpVolume.value = volume.value;
      volume.value = 0;
      return;
    }

    await audioPlayer.setVolume(tmpVolume.value);
    volume.value = tmpVolume.value;
  }
}
