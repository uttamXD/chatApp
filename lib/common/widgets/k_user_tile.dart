import 'package:chat_app/common/constants/ui_helpers.dart';
import 'package:flutter/material.dart';

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
            const Icon(Icons.person),
            sWidthSpan,
            //user name
            Text(text),
          ],
        ),
      ),
    );
  }
}
