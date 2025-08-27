import 'package:fitvault/models/register_view/strength_enum.dart';
import 'package:flutter/material.dart';

class StrengthBar extends StatelessWidget {
  final Strength strength;
  final Color color;
  final String label;
  const StrengthBar({
    super.key,
    required this.strength,
    required this.color,
    required this.label,
  });

  int get _segments {
    switch (strength) {
      case Strength.weak:
        return 1;
      case Strength.fair:
        return 2;
      case Strength.good:
        return 3;
      case Strength.strong:
        return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, c) {
            final w = c.maxWidth;
            final segmentWidth = (w - 12) / 4; // 3 gaps of 4px
            return Row(
              children: List.generate(4, (i) {
                final active = i < _segments;
                return Container(
                  width: segmentWidth,
                  height: 8,
                  margin: EdgeInsets.only(right: i == 3 ? 0 : 4),
                  decoration: BoxDecoration(
                    color: active
                        ? color
                        : Colors.white.withValues(
                            alpha: 0.22,
                          ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              }),
            );
          },
        ),
        const SizedBox(height: 6),
        Align(
          alignment: Alignment.centerLeft,
          child: RichText(
            text: TextSpan(
              text: 'Strength: $label',
              style: TextStyle(
                color: Colors.white.withValues(
                  alpha: 0.9,
                ),
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          
        ),
      ],
    );
  }
}
