import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final Widget label;

  const Badge({required this.child, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        child,
        Positioned(
          right: 0,
          top: 2,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
            child: Center(
              child: DefaultTextStyle(
                style: const TextStyle(fontSize: 10, color: Colors.white),
                child: label,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
