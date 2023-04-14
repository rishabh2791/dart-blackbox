class AppConfig{
  late Map<String,dynamic> settings;
  bool _locked = false;
  
  static final AppConfig _instance = AppConfig._internal();

  factory AppConfig(Map<String,dynamic> settings){
    if(!_instance._locked){
      _instance.settings=settings;
      _instance._locked=true;
    }
    return _instance;
  }

  AppConfig._internal();
}