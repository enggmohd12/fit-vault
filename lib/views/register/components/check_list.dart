import 'package:fitvault/models/register_view/rule_item.dart';
import 'package:flutter/material.dart';

class Checklist extends StatelessWidget {
  final List<RuleItem> items;
  const Checklist({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        final color = item.met ? Colors.lightGreenAccent : Colors.white70;
        final icon = item.met
            ? Icons.check_circle
            : Icons.radio_button_unchecked;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 10),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: item.label,
                    style: TextStyle(
                      color: color,
                      fontSize: 13.5,
                      fontWeight: item.met ? FontWeight.w600 : FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
