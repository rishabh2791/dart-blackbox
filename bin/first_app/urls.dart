import 'package:blackbox/urls/urls.dart';

import 'views.dart';

List<URL> urlpatterns = [
  path("", TestView(), "home"),
  path("/{{int:id}}/create/{{str:name}}", SecondView(), "second_view"),
  path("/{{int:id}}/create/{{str:name}}/{{str:second_name}}", SecondView(), "second_view"),
];