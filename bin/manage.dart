import 'package:blackbox/blackbox.dart';
import 'package:blackbox/core/config/config.dart';

import 'settings.dart';

void main(List<String> arguments) async{
  AppConfig(settings);
  parseArguments(arguments);  
}

