import 'package:flutter/material.dart';

class KDrawer extends StatelessWidget {
  const KDrawer({super.key});

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
                    onTap: () {},
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
                    onTap: () {},
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
                onTap: () {},
              ),
            ),
          ],
        ));
  }
}
