
import 'package:blackbox/views/view.dart';

class SecondAppTestView extends TemplateView{
  SecondAppTestView({
    super.templateName = "templates/base.html", 
    super.additionalData,
  });
}

class SecondAppSecondView extends TemplateView{
  SecondAppSecondView({
    super.templateName = "templates/base.html", 
    super.additionalData,
  }){
    super.allowedMethods=["POST"];
  }
}