import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerButton extends StatelessWidget {
  DrawerButton(
      {required this.title, required this.onPressed, required this.dIcon});

  final String title;
  final Function onPressed;
  final Icon dIcon;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onPressed();
      },
      child: ListTile(
        leading: dIcon,
        title: Text(
          '$title',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
