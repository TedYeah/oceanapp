import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({super.key});

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool isGreen = true;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isGreen ? const Color.fromARGB(255, 76, 76, 175) : Colors.red,
      ),
      onPressed: () {
        setState(() {
          isGreen = !isGreen;
        });
      },
      child: Text(isGreen ? "綠色" : "紅色"),
    );
  }
}
