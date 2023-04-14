

import 'package:blackbox/core/command/command.dart';

var version = "0.0.1";
var release = Releases.alpha;

enum Releases {alpha, beta, release}

void runCommand(List arguments, Map<String,dynamic> env){
  if(arguments.isEmpty){
    throw Exception("Invalid Commands");
  }
}

void parseArguments(List<String> arguments){
  if(arguments.isEmpty){
    throw Exception("Invalid Command,\n run manage.dart --help for more information.");
  }
  
  String command = arguments[0];
  
  arguments = arguments.sublist(1, arguments.length);
  
  List<String> args = getARGS(arguments);
  
  Map<String, String> kwargs = getKWARGS(arguments);
  
  executeCommand(command, args, kwargs);
}

List<String> getARGS(List<String> arguments){
  List<String> filteredArgs = arguments.where((argument) => !argument.contains(":")).toList();
  List<String> args = filteredArgs;
  return args;
}

Map<String, String> getKWARGS(List<String> arguments){
  Map<String, String> kwargs = {};
  arguments = arguments.where((element) => element.contains(":")).toList();
  for(var argument in arguments){
    String key = argument.split(":")[0];
    String value = argument.split(":")[1];
    kwargs[key] = value;
  }
  return kwargs;
}