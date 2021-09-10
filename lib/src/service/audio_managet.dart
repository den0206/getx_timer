import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AudioManager extends GetxService {
  static AudioManager get to => Get.find();
  final _player = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

  late AudioCache _cache;

  @override
  @override
  void onInit() async {
    super.onInit();

    await initPlayer();
  }

  void onClose() {
    super.onClose();
    _cache.clearAll();
  }

  Future<void> initPlayer() async {
    this._cache = AudioCache(prefix: "assets/sounds/", fixedPlayer: _player);

    final List<String> sounds = [
      "boxing2.mp3",
      "finish-sound.mp3",
      "start-sound.mp3",
    ];
    await _cache.loadAll(sounds);
  }

  Future<void> playSound(String path) async {
    await _cache.play(path, mode: PlayerMode.LOW_LATENCY, isNotification: true);
  }

  void stopAudio() {
    if (_player.state == PlayerState.PLAYING) _player.stop();
  }
}
