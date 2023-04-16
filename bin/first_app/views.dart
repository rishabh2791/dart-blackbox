
import 'package:blackbox/views/view.dart';

class TestView extends TemplateView{
  TestView({
    super.templateName = "templates/base.html", 
    super.additionalData,
  });
}

class SecondView extends CreateView{
  SecondView(){
    super.allowedMethods=["POST"];
  }
}