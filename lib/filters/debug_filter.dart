import 'package:nemo/event/log_event.dart';

import 'log_filter.dart';

/// Default implementation of [LogFilter].
///
/// Prints all logs with `level >= Logger.level` while in debug mode. In release
/// mode all logs are omitted.
class DebugFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    var shouldLog = false;
    assert(() {
      if (event.level.levelIndex >= level.index) {
        shouldLog = true;
      }
      return true;
    }());
    return shouldLog;
  }
}
