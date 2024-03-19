import 'package:chat_app/features/login/view/login_page.dart';
import 'package:chat_app/features/register/view/register_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: '/register', page: () => RegisterPage()),
    // GetPage(name: '/authGate', page: () => const AuthGate()),
    // GetPage(name: '/settings', page: () => const SettingsPage())
  ];
}
