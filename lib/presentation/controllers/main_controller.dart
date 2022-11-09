import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:splay/common/state_enum.dart';

import '../../common/enum.dart';

class MainController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();
  late AnimationController animationController;

  Rx<RequestState> stateLibrary = RequestState.empty.obs;

  RxList<NavigationMenuData> navigationMenus = NavigationMenuData.values.obs;
  RxInt selectedNavigationMenu = 0.obs;

  RxInt seekDurationSecond = 10.obs;
  RxBool isRepeat = false.obs;
  RxDouble tmpVolume = 1.0.obs;
  RxDouble volume = 1.0.obs;
  RxDouble turns = 0.0.obs;
  RxBool isPlaying = false.obs;

  Rx<Duration> durationAudio = Duration.zero.obs;
  Rx<Duration> positionAudio = Duration.zero.obs;

  Rxn<FileSystemEntity> playingMusic = Rxn<FileSystemEntity>();
  Rxn<Metadata> playingMusicMetadata = Rxn<Metadata>();

  RxList<FileSystemEntity> myLibrary = <FileSystemEntity>[].obs;
  RxList<Metadata> metadataMyLibrary = <Metadata>[].obs;

  @override
  void onInit() {
    audioPlayer.onPlayerStateChanged.listen((state) {
      setStateAudioPlayer(state);
      if (state == PlayerState.completed) {
        setTurnsDecrement(1 / 4);
        animationController.reverse();
      }
    });

    audioPlayer.onDurationChanged.listen((currentDuration) {
      setDurationAudio(currentDuration);
    });

    audioPlayer.onPositionChanged.listen((currentPosition) {
      setPositionAudio(currentPosition);
    });
    debugPrint('on init');

    super.onInit();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    animationController.dispose();

    debugPrint('on dispose');

    super.dispose();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    animationController.dispose();

    debugPrint('on close');
    super.onClose();
  }

  void changeSelectedNavigationMenu(NavigationMenuData menu) {
    final searchMenuIndex = navigationMenus.indexWhere((item) => item == menu);
    if (selectedNavigationMenu.value == searchMenuIndex) return;
    selectedNavigationMenu.value = searchMenuIndex;
  }

  Future<void> playMusic(FileSystemEntity file, Metadata metadata) async {
    await audioPlayer.play(
      DeviceFileSource(file.path),
    );
    playingMusic.value = file;
    playingMusicMetadata.value = metadata;
    update();
  }

  void setStateAudioPlayer(PlayerState state) {
    setTurnsDecrement(1 / 4);
    if (state == PlayerState.playing) {
      animationController.forward();
    }
  }

  void setDurationAudio(Duration duration) {
    durationAudio.value = duration;
  }

  void setPositionAudio(Duration duration) {
    positionAudio.value = duration;
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
    await audioPlayer.setVolume(value);
    volume.value = value;
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

  Future<void> getFilesFromDirectory() async {
    changeStateLibrary(RequestState.loading);
    try {
      final get = await getDownloadsDirectory();
      if (get == null) return;
      final dir = Directory('E:/Dadang/Lagu/Laguku');
      var tempFiles = <FileSystemEntity>[];
      var completer = Completer<List<FileSystemEntity>>();
      var lister = dir.list(recursive: false);
      lister.listen(
        (file) => tempFiles.add(file),
        // should also register onError
        onDone: () => completer.complete(tempFiles),
      );
      final files = await completer.future;
      final searchMusic = files.where((item) => p.extension(item.path) == '.mp3').toList();
      myLibrary.assignAll(searchMusic);
      await getMetaData();
      changeStateLibrary(RequestState.loaded);
    } catch (e) {
      changeStateLibrary(RequestState.error);
    }
  }

  Future<void> getMetaData() async {
    List<Metadata> metaDataList = [];
    for (var item in myLibrary) {
      final metadata = await MetadataRetriever.fromFile(File(item.path));
      metaDataList.add(metadata);
    }

    metadataMyLibrary.assignAll(metaDataList);
  }

  void changeStateLibrary(RequestState state) {
    stateLibrary.value = state;
    update();
  }
}
