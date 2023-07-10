import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:splay/common/utils.dart';
import 'package:splay/presentation/controllers/main_controller.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({Key? key}) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> with TickerProviderStateMixin {
  final MainController controller = Get.put(MainController());
  final Utils utils = Utils();

  @override
  void initState() {
    controller.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: Obx(
        () => Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SizedBox.fromSize(
                size: const Size(50, 50),
                child: controller.selectedPlayingMusicMetadata.value?.albumArt != null
                    ? Image.memory(controller.selectedPlayingMusicMetadata.value!.albumArt!)
                    : Image.network(
                        'https://cdn.pixabay.com/photo/2019/08/11/18/27/icon-4399630_1280.png',
                      ),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (controller.selectedPlayingMusicMetadata.value?.trackName ?? '').isNotEmpty
                        ? controller.selectedPlayingMusicMetadata.value?.trackName ?? ''
                        : controller.selectedPlayingMusic.value != null
                            ? p.basenameWithoutExtension(
                                controller.selectedPlayingMusic.value!.path)
                            : '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.subtitle1?.copyWith(
                      color: theme.secondaryHeaderColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "${controller.selectedPlayingMusicMetadata.value?.albumArtistName ?? ''}${controller.selectedPlayingMusicMetadata.value?.year != null ? ", ${controller.selectedPlayingMusicMetadata.value?.year}" : ''}",
                    style: theme.textTheme.subtitle2?.copyWith(
                      color: theme.secondaryHeaderColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: controller.seekBackward,
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.shuffle),
                        color: theme.secondaryHeaderColor,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      IconButton(
                        onPressed: controller.seekBackward,
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.skip_previous),
                        color: theme.secondaryHeaderColor,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      IconButton(
                        splashRadius: 20.0,
                        constraints: const BoxConstraints(minHeight: 70, minWidth: 70),
                        onPressed: controller.playOrPause,
                        icon: DecoratedBox(
                          decoration: BoxDecoration(
                            color: theme.secondaryHeaderColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: AnimatedIcon(
                              icon: AnimatedIcons.play_pause,
                              progress: controller.animationController,
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                        tooltip: controller.isPlaying.value ? "Pause" : "Play",
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      IconButton(
                        onPressed: controller.seekForward,
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.skip_next),
                        color: theme.secondaryHeaderColor,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      IconButton(
                        onPressed: controller.changeIsRepeat,
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        icon: Icon(controller.isRepeat.value ? Icons.repeat_one : Icons.repeat),
                        color: theme.secondaryHeaderColor,
                        tooltip: controller.isRepeat.value ? "Repeat Off" : "Repeat One",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        utils.time(controller.positionAudio.value),
                        style: theme.textTheme.subtitle1?.copyWith(
                          color: theme.secondaryHeaderColor,
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        flex: 1,
                        child: SliderTheme(
                          data: SliderThemeData(overlayShape: SliderComponentShape.noOverlay),
                          child: Slider(
                            activeColor: theme.secondaryHeaderColor,
                            thumbColor: theme.secondaryHeaderColor,
                            inactiveColor: theme.secondaryHeaderColor,
                            value: controller.positionAudio.value.inSeconds.toDouble(),
                            min: 0,
                            max: controller.durationAudio.value.inSeconds.toDouble(),
                            onChanged: controller.changeSliderPosition,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        utils.time(controller.durationAudio.value),
                        style: theme.textTheme.subtitle1?.copyWith(
                          color: theme.secondaryHeaderColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: controller.changeIsMute,
              icon: Icon(
                controller.volume.value > 0
                    ? controller.volume.value > 50
                        ? Icons.volume_up_outlined
                        : Icons.volume_down_outlined
                    : Icons.volume_off_outlined,
              ),
              color: theme.secondaryHeaderColor,
              tooltip: controller.volume.value > 0 ? "Turn Off" : "Turn On",
            ),
            SizedBox(
              width: 150,
              child: SliderTheme(
                data: SliderThemeData(overlayShape: SliderComponentShape.noOverlay),
                child: Slider(
                  activeColor: theme.secondaryHeaderColor,
                  thumbColor: theme.secondaryHeaderColor,
                  inactiveColor: theme.secondaryHeaderColor,
                  value: controller.volume.value,
                  min: 0,
                  max: 1,
                  onChanged: controller.changeVolume,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
