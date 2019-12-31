import 'package:nemo/levels/level_bean.dart';
import 'package:nemo/levels/log_level.dart';

class OutputEvent {
  final LevelBean level;
  final List<String> lines;

  OutputEvent(this.level, this.lines);
}