import 'package:chat_app/common/constants/ui_helpers.dart';
import 'package:chat_app/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const UserTile({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    //light and dark mode
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            //icon
            Icon(
              Icons.person,
              color: (isDarkMode ? Colors.grey.shade200 : Colors.grey.shade800),
            ),
            sWidthSpan,
            //user name
            Text(
              text,
              style: TextStyle(
                color:
                    (isDarkMode ? Colors.grey.shade200 : Colors.grey.shade800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
