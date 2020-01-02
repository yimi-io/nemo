
import 'package:nemo/levels/level_bean.dart';
import 'package:nemo/printers/log_printer.dart';
import 'package:nemo/printers/pretty_printer.dart';

import 'event/log_event.dart';
import 'event/output_event.dart';
import 'filters/debug_filter.dart';
import 'filters/log_filter.dart';
import 'levels/log_level.dart';
import 'outputs/console_output.dart';
import 'outputs/log_output.dart';

@Deprecated("Use a custom LogFilter instead")
typedef LogCallback = void Function(LogEvent event);

@Deprecated("Use a custom LogOutput instead")
typedef OutputCallback = void Function(OutputEvent event);

/// Use instances of logger to send log messages to the [LogPrinter].
class Logger {
  /// The current logging level of the app.
  ///
  /// All logs with levels below this level will be omitted.
  static Level level = Level.verbose;

  // NOTE: callbacks are soon to be removed
  static final Set<LogCallback> _logCallbacks = Set();
  // NOTE: callbacks are soon to be removed
  static final Set<OutputCallback> _outputCallbacks = Set();

  final LogFilter _filter;
  final LogPrinter _printer;
  LogOutput _output;
  bool _active = true;

  /// Create a new instance of Logger.
  ///
  /// You can provide a custom [printer], [filter] and [output]. Otherwise the
  /// defaults: [PrettyPrinter], [DebugFilter] and [ConsoleOutput] will be
  /// used.
  Logger({
    LogFilter filter,
    LogPrinter printer,
    LogOutput output,
    Level level,
  })  : _filter = filter ?? DebugFilter(),
        _printer = printer ?? PrettyPrinter(),
        _output = output ?? ConsoleOutput() {
    _filter.init();
    _filter.level = level ?? Logger.level;
    _printer.init();
    _output.init();
  }

  void setOutput(LogOutput output){
    _output = output;
  }

  /// Log a message at level [Level.verbose].
  void v(dynamic message, [dynamic error, StackTrace stackTrace]) {
    log(new LevelBean(levelType: "verbose", levelIndex: Level.verbose.index), message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  void d(dynamic message, [dynamic error, StackTrace stackTrace]) {
    log(new LevelBean(levelType: "debug", levelIndex: Level.debug.index), message, error, stackTrace);
  }

  /// Log a message at level [Level.info].
  void i(dynamic message, [dynamic error, StackTrace stackTrace]) {
    log(new LevelBean(levelType: "info", levelIndex: Level.info.index), message, error, stackTrace);
  }

  /// Log a message at level [Level.warning].
  void w(dynamic message, [dynamic error, StackTrace stackTrace]) {
    log(new LevelBean(levelType: "warning", levelIndex: Level.warning.index), message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  void e(dynamic message, [dynamic error, StackTrace stackTrace]) {
    log(new LevelBean(levelType: "error", levelIndex: Level.error.index), message, error, stackTrace);
  }
  void other(String levelType, dynamic message, [dynamic error, StackTrace stackTrace]){
    LevelBean bean = new LevelBean(levelIndex: LogLevels.leves.length, levelType: levelType);
    log( LogLevels.leves.firstWhere((levenBean) => levenBean.levelType==levelType, orElse: () => bean), message, error, stackTrace);
    if(LogLevels.leves.firstWhere((LevelBean levelBean) => levelBean.levelIndex == bean.levelIndex, orElse:() => null) == null){
      LogLevels.leves.add(bean);
    }
  }
  /// Log a message with [level].
  void log(LevelBean level, dynamic message,
      [dynamic error, StackTrace stackTrace]) {
    if (!_active) {
      throw ArgumentError("Logger has already been closed.");
    } else if (error != null && error is StackTrace) {
      throw ArgumentError("Error parameter cannot take a StackTrace!");
    } else if (level.levelType == Level.nothing) {
      throw ArgumentError("Log events cannot have Level.nothing");
    }
    var logEvent = LogEvent(level, message, error, stackTrace);
    if (_filter.shouldLog(logEvent)) {
      // NOTE: callbacks are soon to be removed
      for (var callback in _logCallbacks) {
        callback(logEvent);
      }
      var output = _printer.log(logEvent);

      if (output.isNotEmpty) {
        var outputEvent = OutputEvent(level, output);
        // NOTE: callbacks are soon to be removed
        for (var callback in _outputCallbacks) {
          callback(outputEvent);
        }
        _output.output(outputEvent);
      }
    }
  }

  /// Closes the logger and releases all resources.
  void close() {
    _active = false;
    _filter.destroy();
    _printer.destroy();
    _output.destroy();
  }

  /// Register a [LogCallback] which is called for each new [LogEvent].
  @Deprecated("Use a custom LogFilter instead")
  static void addLogListener(LogCallback callback) {
    _logCallbacks.add(callback);
  }

  /// Removes a [LogCallback] which was previously registered.
  ///
  /// Returns wheter the callback was successfully removed.
  @Deprecated("Use a custom LogFilter instead")
  static bool removeLogListener(LogCallback callback) {
    return _logCallbacks.remove(callback);
  }

  /// Register an [OutputCallback] which is called for each new [OutputEvent].
  @Deprecated("Use a custom LogOutput instead")
  static void addOutputListener(OutputCallback callback) {
    _outputCallbacks.add(callback);
  }

  /// Removes a [OutputCallback] which was previously registered.
  ///
  /// Returns wheter the callback was successfully removed.
  @Deprecated("Use a custom LogOutput instead")
  static void removeOutputListener(OutputCallback callback) {
    _outputCallbacks.remove(callback);
  }
}
