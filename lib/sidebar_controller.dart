import 'package:flutter/material.dart';

class SidebarController extends ChangeNotifier {
  bool _isOpen = false;

  bool get isOpen => _isOpen;

  void openSidebar() {
    _isOpen = true;
    notifyListeners();
  }

  void closeSidebar() {
    _isOpen = false;
    notifyListeners();
  }

  void toggleSidebar() {
    _isOpen = !_isOpen;
    notifyListeners();
  }
}