import 'dart:io';

import 'first_app/first_app.dart';
import 'first_app/tag_types.dart';
import 'second_app/second_app.dart';

Map<String,dynamic> settings = {
  "BASE_DIR" : Directory.current.path,
  "ALLLOWED_HOSTS" : [],
  "APPS" : [
    firstApp,
    secondApp,
  ],
  "APPEND_SLASH" : false,
  "APPEND_APP_NAME_TO_MODEL_NAME" : true,
  "CUSTOM_TAG_TYPES" : [
    YearTag(),
  ],
};