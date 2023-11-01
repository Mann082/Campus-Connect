import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final void Function()? onPressed;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.hintText,
    this.icon,
    this.onPressed,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[600]!.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          )
              // TextField(
              //   decoration: InputDecoration(
              //     border: InputBorder.none,
              //     hintText: hintText,
              //     hintStyle: TextStyle(
              //       color: Colors.black.withOpacity(0.5),
              //     ),
              //   ),
              //   obscureText: obscureText,
              // ),
              ),
          IconButton(onPressed: onPressed, icon: Icon(icon))
        ],
      ),
    );
  }
}
