
import 'package:flutter/material.dart';
import 'package:tasky/Core/Services/prefrances_maneger.dart';
import 'package:tasky/Core/constants/storage_key.dart';


class HomeController with ChangeNotifier {
  String? userName;
  String? userImagePath;


init(){

  loadUserData();
}
  void loadUserData() async {
    userName = PrefrancesManeger().getString(StorageKey.username);
    userImagePath = PrefrancesManeger().getString(StorageKey.userImage);

    notifyListeners();
  }

 


  

}
