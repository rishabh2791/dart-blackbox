import 'dart:io';

import 'package:blackbox/core/http/request.dart';
import 'package:blackbox/views/templates/internal_server_error.dart';
import 'package:blackbox/views/templates/not_allowed.dart';
import 'package:blackbox/views/templates/not_found.dart';
import 'package:blackbox/views/view.dart';

class NotFoundView extends BaseView{
  NotFoundView(){
    super.allowedMethods=[];
  }

  @override
  getResponse(Request request) async {
    request.httpRequest.response.headers.contentType=ContentType.html;
    request.httpRequest.response.statusCode=404;
    request.httpRequest.response.write(notFoundTemplate);
    request.httpRequest.response.close();
  }
}

class MethodNotAllowedView extends BaseView{
  MethodNotAllowedView(){
    super.allowedMethods=[];
  }

  @override
  getResponse(Request request) async {
    request.httpRequest.response.headers.contentType=ContentType.html;
    request.httpRequest.response.statusCode=405;
    request.httpRequest.response.write(notAllowedTemplate);
    request.httpRequest.response.close();
  }
}

class InternalServerErrorView extends BaseView{
  InternalServerErrorView(){
    super.allowedMethods=[];
  }

  @override
  getResponse(Request request) async {
    request.httpRequest.response.headers.contentType=ContentType.html;
    request.httpRequest.response.statusCode=500;
    request.httpRequest.response.write(internalServerErrorTemplate);
    request.httpRequest.response.close();
  }
}