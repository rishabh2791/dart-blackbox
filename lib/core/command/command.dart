import 'dart:io';

import 'package:blackbox/core/template/template.dart';

abstract class Command{
  execute();
}

class RunServer implements Command{
  final String hostname;
  int  port;

  RunServer({
    required this.hostname, 
    required this.port,
  });

  @override
  execute()async{
    var server = await HttpServer.bind(hostname, port);
    await server.forEach((HttpRequest request) {
    Uri uri = request.uri;
    if(routes.containsKey(uri.toString())){
      routes[uri.toString()]!(request);
    }else{
      handlerNotFound(request);
    }
  });
  }
}

class MakeMigrations implements Command{  
  String? appName;

  MakeMigrations({
    this.appName
  });
  
  @override
  execute(){}
}

class Migrate implements Command{
  String? appName;

  Migrate({
    this.appName
  });

  @override
  execute(){}
}

class CreateUser implements Command{
  @override
  execute(){}
}

class CreateSuperuser implements Command{
  @override
  execute(){}
}

class CollectStatic implements Command{
  @override
  execute(){}
}

class StartApp implements Command{
  String appName;

  StartApp({
    required this.appName
  });

  @override
  execute(){}
}

void executeCommand(String command, List<String> args, Map<String,dynamic> kwargs){
  switch (command) {
    case "runserver":
      String host = kwargs["host"]??"localhost";
      String port = kwargs["port"]??"8000";
      try{
        Command command = RunServer(hostname: host, port: int.parse(port));
        command.execute();
      }catch(e){
        throw Exception("Port $port is not a valid port to run server.");
      }
      break;
    case "makemigrations":
      String? appName = args[0];
      Command command = MakeMigrations(appName: appName);
      command.execute();
      break;
    case "migrate":
      String? appName = args[0];
      Command command = Migrate(appName: appName);
      command.execute();
      break;
    case "createuser":
      Command command = CreateUser();
      command.execute();
      break;
    case "createsuperuser":
      Command command = CreateSuperuser();
      command.execute();
      break;
    case "collectstatic":
      Command command = CollectStatic();
      command.execute();
      break;
    case "startapp":
      String appName = args[0];
      Command command = StartApp(appName: appName);
      command.execute();
      break;
    default:
      throw Exception("Invalid Command");
  }
}

void runserver(String host, port)async{
  var server = await HttpServer.bind(host, int.parse(port));
  await server.forEach((HttpRequest request) {
    Uri uri = request.uri;
    if(routes.containsKey(uri.toString())){
      routes[uri.toString()]!(request);
    }else{
      handlerNotFound(request);
    }
  });
}

Map<String, Function> routes = {
  "/": handler1,
  "/2": handler2,
};

void handler1(HttpRequest request)async{
  request.response.headers.contentType=ContentType.html;
  request.response.write(await parseTemplate("templates/base.html", data: {"title": "Blackbox - Home Page"}));
  request.response.close();
}

void handler2(HttpRequest request){
  request.response.write('This is second handler.');
  request.response.close();
}

void handlerNotFound(HttpRequest request){
  request.response.write('404 Content Not Found');
  request.response.close();
}