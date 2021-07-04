import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uber_clone/main.dart';
import 'package:uber_clone/screens/main_screen.dart';
import 'package:uber_clone/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String id = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/uber-logo.png',
              height: 200,
              width: 200,
            ),
            Text(
              'Login as a Rider',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                ),
              ),
            ),
            SizedBox(
              height: 23,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 5),
              child: TextFormField(
                controller: emailTextEditingController,
                cursorColor: Colors.grey,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your email address',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 5),
              child: TextFormField(
                controller: passwordTextEditingController,
                obscureText: true,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  hintText: 'Enter your Password',
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
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              height: 49,
              minWidth: 330,
              color: Colors.black,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(34)),
              onPressed: () async {
                try {
                  final user = await _firebaseAuth.signInWithEmailAndPassword(
                      email: emailTextEditingController.text,
                      password: passwordTextEditingController.text);
                  // final User pUser = await _firebaseAuth;
                  // final userId = pUser.uid;
                  // print(pUser.uid);
                  // print(pUser.email);

                  if (user != null) {

                    Navigator.pushNamedAndRemoveUntil(
                        context, MainScreen.id, (route) => false);
                    Fluttertoast.showToast(msg: 'Login Succesful');
                    // print('helo');
                    // userRef
                    //     .child(pUser.uid)
                    //     .once()
                    //     .then((value) => (DataSnapshot snap) {
                    //           if (snap.value != null) {
                    //             Navigator.pushNamedAndRemoveUntil(
                    //                 context, MainScreen.id, (route) => false);
                    //             Fluttertoast.showToast(msg: 'Login Succesful');
                    //             print('login');
                    //           }
                    //         });
                  }
                } catch (e) {
                  print(e);
                  Fluttertoast.showToast(msg: e.toString());
                }
              },
              child: Text(
                'Login',
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 17)),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, RegistrationScreen.id, (route) => false);
              },
              child: RichText(
                text: TextSpan(
                    text: 'Dont have an account?',
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Register',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
