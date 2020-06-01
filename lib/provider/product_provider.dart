import 'package:flutter/material.dart';
class ProductProvider with ChangeNotifier{
  List<String> selectedColors =[];
  addColors(String color){
    selectedColors.add(color);
    notifyListeners();
  }
  removeColors(String color){
    selectedColors.remove(color);
    notifyListeners();
  }
}