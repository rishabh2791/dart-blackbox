import 'dart:io';

import 'package:blackbox/core/config/config.dart';

var reg = RegExp(r'\{\{[a-zA-Z0-9 +.:]+\}\}');

Future<String> parseTemplate(String tmpl, {Map<String,dynamic> data = const {}})async{
  String tem = "";
  AppConfig appConfig = AppConfig({});
  String baseDir = appConfig.settings["BASE_DIR"];
  await File('$baseDir/$tmpl').readAsString().then((content) {
    tem = content;
  });
  tem = tem.replaceAllMapped(reg, (match) {return parseDataTag(match, data);});
  return tem;
}

/*
  Tags include 
  {{ }} for displaying data
  {% %} for loops
*/

String parseDataTag(Match match, Map<String, dynamic> data){
  String tag = match.group(0)!.replaceAll("{{", "").replaceAll("}}", "").trim();
  String tem = "";
  if (data.containsKey(tag)){
    tem = data[tag];
  }
  return tem;
}
