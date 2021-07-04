import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

final db = FirebaseDatabase.instance;

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  static String id = 'test_screen';

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  TextEditingController testVariable = TextEditingController();
  final ref = db.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[
          SizedBox(
            height: 300,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 5),
            child: TextFormField(
              controller: testVariable,
              cursorColor: Colors.grey,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: 'Name',
                hintStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(42)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(42)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(42))),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              ref.child('name').set({'name': testVariable.text});
              print('done');
            },
            child: Text(
              'Submit'
            ),
            color: Colors.blue,
            height: 40,
            minWidth: 80,
          ),
        ],
      ),
    );
  }
}
