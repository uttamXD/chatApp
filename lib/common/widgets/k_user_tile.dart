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
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            //icon
            const Icon(Icons.person),
            //user name
            Text(text),
          ],
        ),
      ),
    );
  }
}
