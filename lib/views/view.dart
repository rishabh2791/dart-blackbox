import 'dart:io';

import 'package:blackbox/core/http/request.dart';
import 'package:blackbox/core/template/template.dart';
import 'package:blackbox/views/standard_views.dart';

typedef Handler = Function(HttpRequest);

abstract class View {
  getResponse(Request request);
  get();
  post();
  put();
  patch();
  delete();
  head();
  options();
  trace();
}

class BaseView implements View{
  List<String> allowedMethods =[
    "get",
    "post",
    "put",
    "patch",
    "delete",
    "head",
    "options",
    "trace",
  ];
  Map<String,String> kwargs;

  BaseView({
    this.kwargs = const {},
  });

  @override
  getResponse(Request request) async {
    if(!allowedMethods.contains(request.httpRequest.method.toLowerCase())){
      MethodNotAllowedView().getResponse(request);
      return;
    }
    request.httpRequest.response.write("Testing");
    request.httpRequest.response.close();
  }

  @override
  get(){}

  @override
  post(){}
  
  @override
  put(){}
  
  @override
  patch(){}
  
  @override
  delete(){}
  
  @override
  head(){}
  
  @override
  options(){}
  
  @override
  trace(){}
}

class TemplateView extends BaseView{
  String templateName;
  Map<String,dynamic> additionalData;

  TemplateView({
    required this.templateName,
    this.additionalData=const {},
  }){
    super.allowedMethods=["get"];
  }

  @override
  getResponse(Request request)async{
      request.httpRequest.response.headers.contentType=ContentType.html;
      request.httpRequest.response.write(await parseTemplate(templateName, data: request.context));
      request.httpRequest.response.close();
  }
}

class CreateView extends BaseView{

  CreateView(){
    super.allowedMethods=["post"];
  }
}


//TODO function based view
render(){}

//TODO function based view
redirect(){}