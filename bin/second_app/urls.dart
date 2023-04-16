import 'package:blackbox/urls/urls.dart';

import 'views.dart';

List<URL> urlpatterns = [
  path("/second", SecondAppTestView()),
  path("/second/{{int:id}}/create/{{str:name}}", SecondAppSecondView()),
];