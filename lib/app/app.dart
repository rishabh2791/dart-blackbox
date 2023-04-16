import 'package:blackbox/forms/forms.dart';
import 'package:blackbox/model/model.dart';
import 'package:blackbox/urls/urls.dart';
import 'package:blackbox/views/view.dart';

typedef URLPattern = Map<String,View>;

class App {
  String appName;
  List<Model> models=[];
  List<URL> urls=[];
  List<Forms> forms;

  App({
    this.appName="",
    required this.models,
    required this.urls,
    this.forms = const [],
  });

  register(){
    for(var url in urls){
      url.register();
    }
  }
}