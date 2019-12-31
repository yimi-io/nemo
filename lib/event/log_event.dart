import 'package:nemo/levels/level_bean.dart';
import 'package:nemo/levels/log_level.dart';

class LogEvent{
  final LevelBean level;
  final dynamic message;
  final dynamic error;
  final StackTrace stackTrace;

  LogEvent(this.level, this.message, this.error, this.stackTrace);
}