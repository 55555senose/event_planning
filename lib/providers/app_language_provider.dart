import 'package:flutter/cupertino.dart';

class AppLanguageProvider extends ChangeNotifier{
//todo: data
String appLanguage = 'en' ;

//todo: change language
void changeLanguage(String newLanguage){
  if(appLanguage == newLanguage){
    return ;
  }
  //todo:appLanguage => default => current language
  //todo:newLanguage => uesr select new language
  appLanguage = newLanguage ;
  //todo: after change data => call function
  notifyListeners();
}
}