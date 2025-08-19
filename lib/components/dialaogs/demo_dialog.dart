import 'package:flutter/material.dart';

Future<void> showIndigoDialog(BuildContext context) {
  final cs = Theme.of(context).colorScheme;
  return showDialog(
    context: context,
    barrierDismissible: true, // tap outside to dismiss
    builder: (context) {
      return AlertDialog(
        // Extra styling beyond DialogTheme (optional)
        backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
        shape:
            Theme.of(context).dialogTheme.shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
            const Expanded(child: Text('Indigo Dialog')),
          ],
        ),

        content: const Text(
          'This is a custom dialog styled with an indigo theme. '
          'It keeps the familiar AlertDialog behavior but looks more polished.',
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: cs.primary,
            ),
            child: const Text('CANCEL'),
          ),
          FilledButton(
            onPressed: () {
              // handle confirm
              Navigator.of(context).pop();
            },
            style: FilledButton.styleFrom(
              backgroundColor: cs.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('CONFIRM'),
          ),
        ],
      );
    },
  );
}
