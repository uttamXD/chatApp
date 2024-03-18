import 'package:flutter/material.dart';

class KButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const KButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
