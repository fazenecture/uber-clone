import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.white,

        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      ),
    );
  }
}