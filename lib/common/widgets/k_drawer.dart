import 'package:chat_app/common/services/authentication/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/settings/settings_page.dart';
import '../../theme/theme_provider.dart';

class KDrawer extends StatelessWidget {
  const KDrawer({super.key});

  void logout() {
    //suthService
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Image.asset('asset/logo/chat.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: ListTile(
                  title: Text(
                    "H O M E",
                    style: TextStyle(
                      color: (isDarkMode
                          ? Colors.grey.shade200
                          : Colors.grey.shade800),
                    ),
                  ),
                  leading: Icon(
                    Icons.home,
                    color: (isDarkMode
                        ? Colors.grey.shade200
                        : Colors.grey.shade800),
                  ),
                  onTap: () {
                    //pop the drawer
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: ListTile(
                  title: Text(
                    "S E T T I N G S",
                    style: TextStyle(
                      color: (isDarkMode
                          ? Colors.grey.shade200
                          : Colors.grey.shade800),
                    ),
                  ),
                  leading: Icon(
                    Icons.settings,
                    color: (isDarkMode
                        ? Colors.grey.shade200
                        : Colors.grey.shade800),
                  ),
                  onTap: () {
                    //pop the drawer
                    Navigator.pop(context);
                    //navigate to settings page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 24),
            child: ListTile(
              title: Text(
                "L O G O U T",
                style: TextStyle(
                  color: (isDarkMode
                      ? Colors.grey.shade200
                      : Colors.grey.shade800),
                ),
              ),
              leading: Icon(
                Icons.logout,
                color:
                    (isDarkMode ? Colors.grey.shade200 : Colors.grey.shade800),
              ),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
