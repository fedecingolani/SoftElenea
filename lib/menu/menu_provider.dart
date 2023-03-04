import 'package:flutter/foundation.dart';

class MenuProvider extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  set index(int index) {
    _index = index;
    notifyListeners();
  }

  bool _selectedMenu = false;
  bool get selectedMenu => _selectedMenu;
  set selectedMenu(bool value) {
    _selectedMenu = value;
    notifyListeners();
  }
}
