import 'package:flutter/material.dart';

class TabCustom extends StatelessWidget {
  final String text;
  final bool isSelected;

  const TabCustom({
    required this.text,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFF3EDFF)
              : const Color.fromRGBO(246, 246, 251, 1),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            width: 2,
            color: isSelected
                ? const Color(0xFFF3EDFF)
                : const Color.fromRGBO(246, 246, 251, 1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(text,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400))),
          ],
        ),
      ),
    );
  }
}
