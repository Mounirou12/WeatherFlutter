import 'package:flutter/material.dart';

class AdditionalIInfoItem extends StatelessWidget {
  final IconData icon;
  final  String label;
  final String value;
  const AdditionalIInfoItem({
    super.key,
    required this.icon,
    required this.label, required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 40),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
