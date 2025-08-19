import 'package:flutter/material.dart';

Future<bool> showValidationDialog({
  required BuildContext context,
  required subTitle,
}) async {
  final cs = Theme.of(context).colorScheme;
  return await showDialog<bool>(
        context: context,
        barrierDismissible: false, // Prevent dismissing by tapping outside
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
            shape:
                Theme.of(context).dialogTheme.shape ??
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
            titlePadding: const EdgeInsets.fromLTRB(24, 20, 16, 0),
            contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
            actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            title: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: cs.primary.withValues(
                      alpha: 0.12,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.info, color: cs.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'Validation',
                      style: TextStyle(
                        color: Color(0xFF1A237E),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            content: RichText(
              text: TextSpan(
                text: subTitle,
                style: TextStyle(
                  color: Color(0xFF303F9F),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            actions: <Widget>[
              FilledButton(
                onPressed: () {
                  // handle confirm
                  Navigator.of(context).pop(true);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: cs.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'OKAY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),

                
              ),
            ],
          );
        },
      ) ??
      false; // Return false if dialog is dismissed
}
