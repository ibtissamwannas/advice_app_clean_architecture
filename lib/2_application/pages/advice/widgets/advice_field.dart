import 'package:flutter/material.dart';

class AdviceField extends StatelessWidget {
  static String emptyAdvice = 'Advice is waiting for you...';
  final String advice;
  const AdviceField({super.key, required this.advice});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Material(
      elevation: 20,
      borderRadius: BorderRadius.circular(15),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              15,
            ),
            color: themeData.colorScheme.onPrimary,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            child: Text(
              advice.isNotEmpty ? '''" $advice "''' : emptyAdvice,
              style: themeData.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}
