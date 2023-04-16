Exception invalidCommandException = Exception("Invalid Command. \t Run manage.dart help for more help & options");
Exception invalidInt = Exception("Unable to convert to int");
Exception invalidTagType(String url){
  return Exception("Invalid tag for URL: $url. Valid Types are int, str & uuid.");
}