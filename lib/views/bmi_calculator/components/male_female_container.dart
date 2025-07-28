import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MaleFemaleContainer extends StatelessWidget {
  final String gender;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Size size;
  const MaleFemaleContainer({
    super.key,
    required this.gender,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.width * 0.4,
        width: size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: isSelected ? Border.all(
            color: Color(0xFF283593), // Deep Blue
            width: 2,
          ) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            FaIcon(
              icon,
              color: Colors.indigo,
              size: 50,
            ),
            RichText(
              text: TextSpan(
                text: gender,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF283593), // Deep Blue
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
