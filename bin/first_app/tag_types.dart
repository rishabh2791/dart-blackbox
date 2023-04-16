import 'package:blackbox/urls/tag_types.dart';

class YearTag extends BaseTagType{
  YearTag({
    super.tagName = "year", 
    super.tagPattern = "[0-9]{4}",
  }){
    super.register();
  }
}