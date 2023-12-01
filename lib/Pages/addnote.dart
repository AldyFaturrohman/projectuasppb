import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late String title;
  late String des;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Color.fromARGB(255, 255, 223, 186),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(
                12.0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios_outlined,
                              size: 24.0,
                            ),
                            Text(
                              "  Notes  "
                            ),
                          ],
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 190, 138, 98),
                          ),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 8.0,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: add,
                        child: Text(
                          "Save",
                          style: GoogleFonts.poppins(
                            fontSize: 18.0,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 190, 138, 98),
                          ),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(
                              horizontal: 25.0,
                              vertical: 8.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //
                  SizedBox(
                    height: 12.0,
                  ),
                  //
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration.collapsed(
                            hintText: "Title",
                            hintStyle: TextStyle(
                              color: const Color.fromARGB(100, 0, 0, 0),
                            ),
                          ),
                          style: GoogleFonts.poppins(
                            fontSize: 32.0,
                            color: Colors.black,
                          ),
                          onChanged: (_val) {
                            title = _val;
                          },
                        ),
                        //
                        Container(
                          height: MediaQuery.of(context).size.height * 0.75,
                          padding: const EdgeInsets.only(top: 12.0),
                          child: TextFormField(
                            decoration: InputDecoration.collapsed(
                              hintText: "Note Description",
                              hintStyle: TextStyle(
                                color: const Color.fromARGB(100, 0, 0, 0),
                              ),
                            ),
                            style: GoogleFonts.poppins(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                            onChanged: (_val) {
                              des = _val;
                            },
                            maxLines: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void add() async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('notes');

    var data = {
      'title': title,
      'description': des,
      'created': DateTime.now(),
    };

    ref.add(data);

    Navigator.pop(context);
  }
}