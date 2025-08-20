import 'package:flutter/material.dart';

class ToggleComponent extends StatelessWidget {
  final Function(int) onTap;
  final int selectedValue;

  const ToggleComponent({
    super.key,
    required this.onTap,
    required this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Row(children: [
          _DegreeComponent(
            isSelected: selectedValue == 0,
            onTap: () {
              onTap(0);
            },
            text: "°C",
            value: 0,
          ),
          _DegreeComponent(
            isSelected: selectedValue == 1,
            onTap: () {
              onTap(1);
            },
            text: "°F",
            value: 1,
          ),
        ]),
      ),
    );
  }
}

class _DegreeComponent extends StatelessWidget {
  const _DegreeComponent({
    required this.onTap,
    required this.value,
    required this.isSelected,
    required this.text,
  });

  final int value;
  final VoidCallback onTap;
  final bool isSelected;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isSelected ? Colors.white : Colors.transparent),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
