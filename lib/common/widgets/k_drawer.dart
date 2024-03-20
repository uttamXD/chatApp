import 'package:chat_app/common/services/authentication/auth_service.dart';
import 'package:flutter/material.dart';
import '../../features/settings/settings_page.dart';

class KDrawer extends StatelessWidget {
  const KDrawer({super.key});

  void logout() {
    //suthService
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(
                child: Center(
                  child: Icon(Icons.message),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: ListTile(
                  title: const Text(
                    "H O M E",
                  ),
                  leading: const Icon(
                    Icons.home,
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
                  title: const Text(
                    "S E T T I N G S",
                  ),
                  leading: const Icon(
                    Icons.settings,
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
              title: const Text(
                "L O G O U T",
              ),
              leading: const Icon(
                Icons.logout,
              ),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
