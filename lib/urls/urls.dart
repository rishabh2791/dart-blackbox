import 'package:blackbox/core/config/config.dart';
import 'package:blackbox/core/exceptions.dart';
import 'package:blackbox/urls/tag_types.dart';
import 'package:blackbox/views/view.dart';

Map<String,View> appURLPatterns = {};
var tagNameRegex = RegExp(r'\{\{[a-z]+\:([a-zA-Z0-9_]+)\}\}');
Map<String, String> matchers ={};
Map<String, View> namedMatchers = {};
Map<String,Map<String,List<String>>> tags = {};
Map<String, List<String>> parts = {};

abstract class URL{
  register();
}

class BaseURL implements URL{
  String path;
  View view;
  String name;

  BaseURL({
    required this.path,
    required this.view,
    this.name = "",
  });

  @override
  register(){
    AppConfig appConfig = AppConfig({});
    String newPattern = path;
    Iterable<RegExpMatch> matches = tagNameRegex.allMatches(path);
    Map<String,List<String>> newTags = {};

    for(var match in matches){
      TypeAndTag typeAndTag = TypeAndTag(match.group(0).toString());
      if (!newTags.containsKey(regexPatterns[typeAndTag.type]!)){
        newTags[regexPatterns[typeAndTag.type]!]=[];
      }
      newTags[regexPatterns[typeAndTag.type]!]!.add(typeAndTag.tag);
      if(regexPatterns.containsKey(typeAndTag.type)){
        newPattern = newPattern.replaceAll(match.group(0).toString(), regexPatterns[typeAndTag.type]!);
      }else{
        throw invalidTagType(path);
      }
    }
    if(appConfig.settings.containsKey("APPEND_SLASH") && appConfig.settings["APPEND_SLASH"]){
      if(newPattern.isNotEmpty && newPattern[newPattern.length-1]!="/"){
        newPattern = "$newPattern/";
      }
    }
    newPattern = "^$newPattern\$";
    matchers[newPattern] = path;
    appURLPatterns[newPattern] = view;
    tags[newPattern] = newTags;
    if(name.isNotEmpty){
      namedMatchers[name] = view;
    }
    parts[newPattern]=path.split("/");
    parts[newPattern]!.removeWhere((element) => element.isEmpty);
  }
}

URL path(String path, View view, [String name = ""]){
  BaseURL baseURL = BaseURL(path: path, view: view, name: name);
  return baseURL;
}

class TypeAndTag{
  String type = "";
  String tag = "";

  TypeAndTag(String match){
    String newMatch = match.replaceAll("{{", "").replaceAll("}}", "");
    type = newMatch.split(":")[0];
    tag = newMatch.split(":")[1];
  }
}