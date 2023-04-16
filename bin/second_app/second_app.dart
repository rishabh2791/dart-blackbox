

import 'package:blackbox/app/app.dart';

import 'forms.dart';
import 'models.dart';
import 'urls.dart';

SecondApp secondApp = SecondApp(
  appName: "second_app",
  models: [
    SecondAppModel(),
  ], 
  urls: urlpatterns,
  forms: [
    SecondAppForm(),
  ],
);

class SecondApp extends App{
  SecondApp({
    super.appName = "",
    required super.models,
    required super.urls,
    super.forms = const [],
  });
}