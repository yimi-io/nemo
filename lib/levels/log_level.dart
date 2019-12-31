
import 'level_bean.dart';

enum Level {
  verbose,
  debug,
  info,
  warning,
  error,
  wtf,
  nothing,
}
class LogLevels{
  static var leves = List<LevelBean>();
  static LogLevels get instance => getInstance();
  static LogLevels _instance ;
  LogLevels.init(){
     leves.add(LevelBean(levelType: "verbose", levelIndex:  Level.verbose.index));
     leves.add(LevelBean(levelType: "debug", levelIndex:  Level.debug.index));
     leves.add(LevelBean(levelType: "info", levelIndex:  Level.info.index));
     leves.add(LevelBean(levelType: "warning", levelIndex:  Level.warning.index));
     leves.add(LevelBean(levelType: "error", levelIndex:  Level.error.index));
     leves.add(LevelBean(levelType: "wtf", levelIndex:  Level.wtf.index));
     leves.add(LevelBean(levelType: "nothing", levelIndex:  Level.nothing.index));
  }
  void addLevels(List<String> list){
    int index = leves.length;
    for(var string in list){
      leves.add(new LevelBean(levelIndex: index, levelType: string));
    }
  }

  static getInstance(){
    if(_instance == null){
      _instance = LogLevels.init();
    }
    return _instance;
  }
}