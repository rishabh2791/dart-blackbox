import 'dart:io';

class Request{
  HttpRequest httpRequest;
  Map<String,dynamic> context;

  Request({
    required this.httpRequest,
    this.context = const {},
  });
}