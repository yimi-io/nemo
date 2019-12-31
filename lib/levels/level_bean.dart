class LevelBean{
  dynamic levelType;
  int levelIndex;
  LevelBean({
    this.levelType,
    this.levelIndex
  });
  LevelBean.from(dynamic levelType, int levelIndex){
    this.levelType = levelType;
    this.levelIndex = levelIndex;
  }
}