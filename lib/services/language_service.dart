import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService extends ChangeNotifier {
  static const String _languageKey = 'selected_language';
  
  Locale _currentLocale = const Locale('en', '');
  
  Locale get currentLocale => _currentLocale;
  
  bool get isArabic => _currentLocale.languageCode == 'ar';
  bool get isEnglish => _currentLocale.languageCode == 'en';
  
  LanguageService() {
    _loadLanguage();
  }
  
  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageKey) ?? 'en';
    _currentLocale = Locale(languageCode, '');
    notifyListeners();
  }
  
  Future<void> setLanguage(Locale locale) async {
    _currentLocale = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, locale.languageCode);
    notifyListeners();
  }
  
  Future<void> toggleLanguage() async {
    final newLocale = isEnglish ? const Locale('ar', '') : const Locale('en', '');
    await setLanguage(newLocale);
  }
  
  String getLanguageName() {
    return isArabic ? 'العربية' : 'English';
  }
  
  String getLanguageCode() {
    return _currentLocale.languageCode;
  }
}
