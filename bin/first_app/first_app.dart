import 'package:blackbox/app/app.dart';

import 'forms.dart';
import 'models.dart';
import 'urls.dart';

FirstApp firstApp = FirstApp(
  appName: "first_app", //TODO need to check if this name is unique.
  models: [
    FirstAppModel(),
  ], 
  urls: urlpatterns,
  forms: [
    FirstAppForm(),
  ],
);

class FirstApp extends App{
  FirstApp({
    super.appName = "",
    required super.models,
    required super.urls,
    super.forms = const [],
  });
}