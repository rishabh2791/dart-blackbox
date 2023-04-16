abstract class TagType{
  register();
}

Map<String,String> regexPatterns = {};

class BaseTagType implements TagType {
  String tagName;
  String tagPattern;

  BaseTagType({
    required this.tagName,
    required this.tagPattern,
  });

  @override
  register(){
    regexPatterns[tagName] = tagPattern;
  }
}

class IntTagType extends BaseTagType{
  IntTagType({
    super.tagName = "int", 
    super.tagPattern = "([0-9]+)",
  }){
    super.register();
  }
}

class StrTagType extends BaseTagType{
  StrTagType({
    super.tagName = "str", 
    super.tagPattern = "([[a-zA-Z0-9]+)",
  }){
    super.register();
  }
}

class UUIDTagType extends BaseTagType{
  UUIDTagType({
    super.tagName = "uuid", 
    super.tagPattern = "([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})",
  }){
    super.register();
  }
}

registerBasicTagTypes(){
  IntTagType();
  StrTagType();
  UUIDTagType();
}