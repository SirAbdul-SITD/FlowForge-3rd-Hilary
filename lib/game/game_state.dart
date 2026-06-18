// lib/game/game_state.dart
import 'package:flutter/material.dart';
import 'path_level.dart';
import '../utils/preferences.dart';
import '../utils/audio_manager.dart';

class GameState extends ChangeNotifier {
  late PathLevel level;
  final List<int> path = []; // current drawn path
  bool isComplete = false;
  int stars = 0;
  int restarts = 0;
  int currentLevelIndex = 0;
  bool initialized = false;

  void loadLevel(int index) {
    currentLevelIndex = index;
    level = LevelGenerator.generate(index);
    path
      ..clear()
      ..add(level.start);
    isComplete = false;
    stars = 0;
    restarts = 0;
    initialized = true;
    notifyListeners();
  }

  int get size => level.size;
  bool inPath(int cell) => path.contains(cell);
  int? get head => path.isEmpty ? null : path.last;

  bool _adjacent(int a, int b) {
    final dr = (a ~/ size - b ~/ size).abs();
    final dc = (a % size - b % size).abs();
    return dr + dc == 1;
  }

  /// Called as the finger moves onto [cell].
  void extendTo(int cell) {
    if (isComplete || path.isEmpty) return;
    // backtrack if returning to the previous cell
    if (path.length >= 2 && cell == path[path.length - 2]) {
      path.removeLast();
      AudioManager.instance.playDraw();
      notifyListeners();
      return;
    }
    if (path.contains(cell)) return;
    if (!_adjacent(path.last, cell)) return;
    path.add(cell);
    AudioManager.instance.playDraw();
    _check();
    notifyListeners();
  }

  /// Begin a fresh draw if the user starts on the start cell.
  void beginAt(int cell) {
    if (isComplete) return;
    if (cell == level.start) {
      path
        ..clear()
        ..add(level.start);
      notifyListeners();
    }
  }

  void _check() {
    if (path.length == size * size &&
        path.last == level.end &&
        !isComplete) {
      isComplete = true;
      stars = _calcStars();
      AudioManager.instance.playComplete();
      Preferences.instance.saveLevelResult(currentLevelIndex, stars);
    }
  }

  int _calcStars() {
    if (restarts == 0) return 3;
    if (restarts <= 2) return 2;
    return 1;
  }

  void restartLevel() {
    path
      ..clear()
      ..add(level.start);
    isComplete = false;
    stars = 0;
    restarts++;
    notifyListeners();
  }

  void hardReset() {
    restarts = 0;
    loadLevel(currentLevelIndex);
  }

  void nextLevel() {
    if (currentLevelIndex < 149) loadLevel(currentLevelIndex + 1);
  }
}
