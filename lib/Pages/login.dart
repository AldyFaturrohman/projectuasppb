import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectuasppb/controller/google_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "images/uns.png",
                    ),
                  ),
                ),
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 12.0,
              ),
              child: Text(
                "Buat Dan Kreasikan Note Mu",
                style: GoogleFonts.poppins(
                  fontSize: 36.0,
                )
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: ElevatedButton(
                onPressed: () {
                  signInWithGoogle(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login Dengan Akun Google",
                      style: GoogleFonts.poppins(
                        fontSize: 15.0,
                      ),
                    ),
                    //
                    SizedBox(
                      width: 10.0,
                    ),
                    //
                    Image.asset(
                      'images/google.png',
                      height: 36.0,
                    ),
                  ],
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.grey[700],
                    ),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                        vertical: 12.0,
                      ),
                    )),
              ),
            ),
            //
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}