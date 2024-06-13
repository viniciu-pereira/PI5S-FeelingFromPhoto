import 'package:flutter/material.dart';

class CustomButtonPicker extends StatelessWidget {
  final String text;
  final Function pick;

  const CustomButtonPicker({
    super.key,
    required this.text,
    required this.pick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          fixedSize: const Size(double.maxFinite, 50),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
          // fixedSize: Size(double.maxFinite, 40),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          pick();
        },
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
