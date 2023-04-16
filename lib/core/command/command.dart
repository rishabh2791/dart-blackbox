import 'dart:io';

import 'package:blackbox/app/app.dart';
import 'package:blackbox/blackbox.dart';
import 'package:blackbox/core/command/exceptions.dart';
import 'package:blackbox/core/command/help.dart';
import 'package:blackbox/core/config/config.dart';
import 'package:blackbox/core/exceptions.dart';
import 'package:blackbox/core/http/request.dart';
import 'package:blackbox/urls/tag_types.dart';
import 'package:blackbox/urls/urls.dart';
import 'package:blackbox/views/standard_views.dart';

abstract class Command{
  execute();
}

class BaseCommand implements Command{
  List<String> args;
  Map<String,String> kwargs;

  BaseCommand({
    required this.args, 
    required this.kwargs,
  });

  @override
  execute() {
    //TODO complete implementation
  }
}

class RunServer extends BaseCommand{
  List<String> ag;
  Map<String,String> kwag;

  RunServer({
    required this.ag,
    required this.kwag,
  }) : super(args: ag, kwargs: kwag);

  String getHostname(Map<String,String> kwargs){
    String  hostname = kwargs["host"]??"localhost";
    return hostname;
  }

  int getPort(Map<String,dynamic> kwargs){
    int port = 8000;
    try {
      port = int.parse(kwargs["port"]??"8000");
    } catch (e) {
      throw invalidInt;
    }
    return port;
  }

  @override
  execute() async {
    AppConfig appConfig = AppConfig({});
    List<App> apps = appConfig.settings["APPS"]??[];
    if(apps.isEmpty){
      throw noAppsRegistered;
    }

    /* 
        Complete all management tasks here.
        Management tasks include:-
        1. Register URLs
        2. Register Models
        3. Register TagTypes
    */

    //Register Standard Tag Types
    registerBasicTagTypes();

    //Register Custom Tag Types
    if(appConfig.settings.containsKey("CUSTOM_TAG_TYPES")){
      List<TagType> customTags = appConfig.settings["CUSTOM_TAG_TYPES"];
      for(var customTag in customTags){
        customTag.register();
      }
    }

    for(var app in apps){
      app.register();
    }

    var server = await HttpServer.bind(getHostname(kwargs), getPort(kwargs));
    await server.forEach((HttpRequest httpRequest) async {
      bool found = false;
      Request request = Request(httpRequest: httpRequest);
      Uri uri = request.httpRequest.uri;
      String path = uri.toString();
      if(appConfig.settings.containsKey("APPEND_SLASH") && !appConfig.settings["APPEND_SLASH"]){
        if(path.isNotEmpty && path[path.length-1]=="/"){
          path = path.substring(0, path.length-1);
        }
      }
      
      appURLPatterns.forEach((urlPattern, view) {
        RegExp check = RegExp(urlPattern);
        if(check.hasMatch(path)){
          Map<String,String> kwargs = {};
          found = true;
          List<String> urlPatternParts = parts[urlPattern]??[];
          List<dynamic> urlParts = path.trim().split("/");
          urlParts.removeWhere((element) => element.isEmpty);
          if(urlPatternParts.length!=urlParts.length){
            found=false;
            InternalServerErrorView().getResponse(request);
          }
          for(var index = 0; index < urlParts.length; index++){
            if(tagNameRegex.hasMatch(urlPatternParts[index])){
              TypeAndTag typeAndTag = TypeAndTag(urlPatternParts[index]);
              kwargs[typeAndTag.tag] = urlParts[index];
            }
          }
          request.context = kwargs;
          if(found){
            view.getResponse(request);
          }
          return;
        }
      });
      
      if(!found){
        NotFoundView notFoundView = NotFoundView();
        notFoundView.getResponse(request);
      }
  });
  }
}

class MakeMigrations extends BaseCommand{  
  List<String> ag;
  Map<String,String> kwag;

  MakeMigrations({
    required this.ag,
    required this.kwag,
  }) : super(args: ag, kwargs: kwag);
  
  @override
  execute(){
    //TODO complete implementation
  }
}

class Migrate extends BaseCommand{
  List<String> ag;
  Map<String,String> kwag;

  Migrate({
    required this.ag,
    required this.kwag,
  }) : super(args: ag, kwargs: kwag);

  @override
  execute(){
    //TODO complete implementation
  }
}

class CreateUser extends BaseCommand{
  List<String> ag;
  Map<String,String> kwag;

  CreateUser({
    required this.ag,
    required this.kwag,
  }) : super(args: ag, kwargs: kwag);

  @override
  execute(){
    //TODO complete implementation
  }
}

class CreateSuperuser extends BaseCommand{
  List<String> ag;
  Map<String,String> kwag;

  CreateSuperuser({
    required this.ag,
    required this.kwag,
  }) : super(args: ag, kwargs: kwag);

  @override
  execute(){
    //TODO complete implementation
  }
}

class CollectStatic extends BaseCommand{
  List<String> ag;
  Map<String,String> kwag;

  CollectStatic({
    required this.ag,
    required this.kwag,
  }) : super(args: ag, kwargs: kwag);

  @override
  execute(){
    //TODO complete implementation
  }
}

class StartApp extends BaseCommand{
  List<String> ag;
  Map<String,String> kwag;

  StartApp({
    required this.ag,
    required this.kwag,
  }) : super(args: ag, kwargs: kwag);

  @override
  execute(){
    //TODO complete implementation
  }
}

class Version extends BaseCommand{
  List<String> ag;
  Map<String,String> kwag;

  Version({
    required this.ag,
    required this.kwag,
  }) : super(args: ag, kwargs: kwag);

  @override
  execute() {
    print("$version-${release.toReadableString()}");
  }
}

class Help extends BaseCommand{
  List<String> ag;
  Map<String,String> kwag;

  Help({
    required this.ag,
    required this.kwag,
  }) : super(args: ag, kwargs: kwag);

  String getCommand(){
    String command = "";
    if(ag.isNotEmpty){
      command = ag[0];
    }
    return command;
  }

  @override
  execute() {
    print(getHelpText(getCommand()));  
  }
}

void executeCommand(String command, List<String> args, Map<String,String> kwargs){
  switch (command) {
    case "runserver":
      Command command = RunServer(ag: args, kwag: kwargs);
      command.execute();
      break;
    case "makemigrations":
      Command command = MakeMigrations(ag: args, kwag: kwargs);
      command.execute();
      break;
    case "migrate":
      Command command = Migrate(ag: args, kwag: kwargs);
      command.execute();
      break;
    case "createuser":
      Command command = CreateUser(ag: args, kwag: kwargs);
      command.execute();
      break;
    case "createsuperuser":
      Command command = CreateSuperuser(ag: args, kwag: kwargs);
      command.execute();
      break;
    case "collectstatic":
      Command command = CollectStatic(ag: args, kwag: kwargs);
      command.execute();
      break;
    case "startapp":
      Command command = StartApp(ag: args, kwag: kwargs);
      command.execute();
      break;
    case "version":
      Command command = Version(ag: args, kwag: kwargs);
      command.execute();
      break;
    case "help":
      Command command = Help(ag: args, kwag: kwargs);
      command.execute();
      break;
    default:
      throw Exception("Invalid Command. Run manage.dart help to get list of valid commands.");
  }
}

// Map<String, View> routes = {
//   "/": TestView(templateName: "templates/base.html"),
//   "/2": SecondView(),
// };

// void handler1(HttpRequest request)async{
//   request.response.headers.contentType=ContentType.html;
//   request.response.write(await parseTemplate("templates/base.html", data: {"title": "Blackbox - Home Page"}));
//   request.response.close();
// }

// void handler2(HttpRequest request){
//   request.response.write('This is second handler.');
//   request.response.close();
// }

// void handlerNotFound(HttpRequest request){
//   request.response.write('404 Content Not Found');
//   request.response.close();
// }