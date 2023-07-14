import 'package:flutter/material.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key, required this.userName, required this.onTap});
  final String userName;
  final VoidCallback onTap;

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Hello, ${widget.userName}',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        InkWell(onTap: () => widget.onTap(), child: const Icon(Icons.settings))
      ],
    );
  }
}
